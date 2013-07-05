//
//  ViewController.h
//  GiPiEs
//
//  Created by LLBER on 09/11/12.
//  Copyright (c) 2012 LLBER. All rights reserved.
//

#import <UIKit/UIKit.h>

// Importar
#import <CoreLocation/CoreLocation.h>

// Importar
#import <MapKit/MapKit.h>


#import <QuartzCore/QuartzCore.h>


// Implementar el protocolo  Establecemos el controlador como delegado de localización (CLLocationManagerDelegate)
@interface ViewController : UIViewController<CLLocationManagerDelegate>



// Mapa
@property (strong, nonatomic) IBOutlet UILabel *datosLatitud;

@property (strong, nonatomic) IBOutlet UILabel *datosLongitud;

@property (strong, nonatomic) IBOutlet MKMapView *mapa;

- (IBAction)activarLocalizacion:(id)sender;

@property (strong, nonatomic) CLLocationManager *controlador;




// Brújula
@property (strong, nonatomic) IBOutlet UILabel *brujula;



@property (strong, nonatomic) IBOutlet UIImageView *ImagenCompas;







@end
