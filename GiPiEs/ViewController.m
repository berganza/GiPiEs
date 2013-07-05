//
//  ViewController.m
//  GiPiEs
//
//  Created by LLBER on 09/11/12.
//  Copyright (c) 2012 LLBER. All rights reserved.
//

#import "ViewController.h"

// insertar el protocolo
#import <CoreLocation/CoreLocation.h>

// Importamos la clase del alfiler
#import "Alfiler.h"



@interface ViewController ()

@end

@implementation ViewController

@synthesize controlador;
@synthesize datosLatitud;
@synthesize datosLongitud;
@synthesize brujula;
@synthesize mapa;
@synthesize ImagenCompas;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Iniciamos el LocationManager
    controlador=[[CLLocationManager alloc] init];
    
    // Establecemos la precisión como la mejor.
    controlador.desiredAccuracy = kCLLocationAccuracyBest;
    
    // El ángulo mínimo que debe cambiar para que se actualize el valor y así iOS informe al sistema del cambio.
    controlador.headingFilter = 1;
    
    
    // Establecemos al propio controlador como el delegado de localización.
    controlador.delegate=self;
    
    
    // Al igual que con los ángulos, con la posición ponemos que se avise de cambios en cuanto haya uno mínimo.
    controlador.distanceFilter = 1;
    
    
    // Comenzamos a comprobar los cambios de localización, para conseguir el Norte Real.
    [controlador startUpdatingLocation];
    
    // Y comenzamos a comprobar el ángulo para encontrar el Norte en nuestra brújula.
    [controlador startUpdatingHeading];
    
    
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (IBAction)activarLocalizacion:(id)sender {
    
    //Clase principal: instanciar
    self.controlador = [[CLLocationManager alloc]init];
    
    
    //Filtro de distancia: cada cuanta distancia nos avisa del cambio (metros??)
    controlador.distanceFilter = 100;
    
    
    // Precisión que queremos: best es la mejor de la que dispone el disposotivo
    // Cuanta menor precisión será más rápida le respuesta
    controlador.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    
    //Al manager le designamos un delegate para capturar los datos
    controlador.delegate = self;
    
    // Comenzar (Activar el GPS)
    [controlador startUpdatingLocation];
    
    // Magnetrómetro
    [controlador startUpdatingHeading];

}

// Ahora podemos capturar diferentes métodos que nos permite el protocolo

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    // Alerta de error
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    
    datosLatitud.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];
    
    datosLongitud.text = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.longitude];
    
    
    
    // Sacar datos por el mapa
    MKCoordinateRegion region;
    
    // Centrar
    region.center.latitude = newLocation.coordinate.latitude;
    region.center.longitude = newLocation.coordinate.longitude;
    
    
    // Medido en grados (1 general, 0.002 a nivel de calle, etc)
    region.span.latitudeDelta = 0.05;
    region.span.longitudeDelta = 0.05;
    
    [mapa setRegion:region animated:YES];
    
    // Implementamos nuestro Alfiler
    Alfiler * pincho = [[Alfiler alloc]init];
    pincho.coordenada = newLocation.coordinate;
    
    // Creamos una anotación en el mapa
    [mapa addAnnotation:pincho];
    
    
        
    
    
    
    
    
}






// Magnetrómetro
// Método llamado al haber un cambio de ángulo.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    // Norte magnético
    brujula.text = [[NSString alloc]initWithFormat:@"%f", newHeading.magneticHeading];
    
    
    
    
    // Convertimos a Radianes el angulo anterior y el nuevo.
    
    float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
    
    float newRad =  -newHeading.trueHeading * M_PI / 180.0f;
    
    
    // Creamos una animación.
    CABasicAnimation *theAnimation;
    
    // Será de tipo rotación
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    // Establecemos los valores del giro.
    theAnimation.fromValue = [NSNumber numberWithFloat:oldRad];
    
    theAnimation.toValue=[NSNumber numberWithFloat:newRad];
    
    // Podemos poner una duración, pero puede resultar retrasado si ponemos tiempo.
    theAnimation.duration = 0.0;
    
    
    // Le aplicamos la animación a la imagen de la brújula.
    [ImagenCompas.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
    
    ImagenCompas.transform = CGAffineTransformMakeRotation(newRad);

    
    
    
    
    
}


-(BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    
    // Muestra por defecto el simbolo del infinito
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end























