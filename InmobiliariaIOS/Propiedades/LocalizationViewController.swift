//
//  LocalizationViewController.swift
//  InmobiliariaIOS
//
//  Created by Porfirio Diaz on 21/12/23.
//

import UIKit
import MapKit
import CoreLocation

class LocalizationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var elMapa = MKMapView()
    var propiedad: Propiedad?
    var header = UITextView()
    var locationManager: CLLocationManager!
    
    @objc func directions() {
        // 1. para obtener indicaciones, necesitamos el punto de origen
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        guard let loc = locations.first else { return }
        let indicaciones = MKDirections.Request()
        indicaciones.source = MKMapItem(placemark:MKPlacemark(coordinate:elMapa.centerCoordinate))
        indicaciones.destination = MKMapItem(placemark:MKPlacemark(coordinate:loc.coordinate))
        indicaciones.transportType = .any
        indicaciones.requestsAlternateRoutes = false
        let rutas = MKDirections(request: indicaciones)
        rutas.calculate { response, error in
            if error != nil {
                print ("NO se obtuvieron rutas \(String(describing:error))")
            }
            else {
                // El arreglo trae todas las rutas que se obtuvieron
                guard let lasRutas = response?.routes else { return }
                //si queremos dibujar solo una...
                guard let laRuta = lasRutas.first else { return }
                self.elMapa.addOverlay(laRuta.polyline)
                self.elMapa.setVisibleMapRect(laRuta.polyline.boundingMapRect, animated:false)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        let ac = UIAlertController(title: "Error", message:"No se puede obtener la ubicación", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) {
            alertaction in
            // Este codigo se ejecutará cuando el usuario toque el botón
        }
        ac.addAction(action)
        self.present(ac, animated: true)
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        elMapa.frame = self.view.bounds.insetBy(dx: 10, dy: 160)
        self.view.addSubview(elMapa)
        self.view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        header.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        elMapa.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if propiedad != nil {
            let centro = CLLocationCoordinate2D(latitude: propiedad!.latitud, longitude: propiedad!.longitud)
            elMapa.setRegion(MKCoordinateRegion(center:centro, latitudinalMeters:5000, longitudinalMeters:5000), animated: true)
            let elPin = MKPointAnnotation()
            elPin.coordinate = centro
            elPin.title = "Tu futura propiedad, aquí"
            elMapa.addAnnotation(elPin)
            header.text = propiedad!.propiedad
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude:propiedad!.latitud, longitude:propiedad!.longitud)) { lugares, error in
                if error != nil {
                    print ("ocurrio un error en la geolocalizacion \(String(describing: error))")
                }
                else {
                    guard let lugar = lugares?.first else { return }
                    let thoroughfare = (lugar.thoroughfare ?? "")
                    let subThoroughfare = (lugar.subThoroughfare ?? "")
                    let locality = (lugar.locality ?? "")
                    let subLocality = (lugar.subLocality ?? "")
                    let administrativeArea = (lugar.administrativeArea ?? "")
                    let subAdministrativeArea = (lugar.subAdministrativeArea ?? "")
                    let postalCode = (lugar.postalCode ?? "")
                    let country = (lugar.country ?? "")
                    let direccion = "\nDirección: \(thoroughfare) \(subThoroughfare) \(locality) \(subLocality) \(administrativeArea) \(subAdministrativeArea) \(postalCode) \(country)"
                    DispatchQueue.main.async {
                        self.header.text += direccion
                    }
                }
            }
        }
    }
    func showLocationOnMap(){
        guard let propiedad = propiedad else { return }

        let location = CLLocationCoordinate2D(latitude: propiedad.latitud, longitude: propiedad.longitud)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Ubicación de la propiedad"
        annotation.subtitle = "\(propiedad.propiedad)"
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // se tiene que implementar para poder mostrar lineas y poligonos
        var lineaParaDibujar = MKPolylineRenderer()
        if let linea = overlay as? MKPolyline {
            lineaParaDibujar = MKPolylineRenderer(polyline: linea)
            lineaParaDibujar.strokeColor = UIColor.blue
            lineaParaDibujar.lineWidth = 2.0
        }
        return lineaParaDibujar
    }
}
