//
//  Alfiler.h
//  GiPiEs
//
//  Created by LLBER on 10/11/12.
//  Copyright (c) 2012 LLBER. All rights reserved.
//

#import <Foundation/Foundation.h>


// Importar protocolos
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>



// El objeto va a implementar un protocolo de anotación de MapKit
@interface Alfiler : NSObject <MKAnnotation>

@property CLLocationCoordinate2D coordenada;



@end
