//
//  Alfiler.m
//  GiPiEs
//
//  Created by LLBER on 10/11/12.
//  Copyright (c) 2012 LLBER. All rights reserved.
//

#import "Alfiler.h"

@implementation Alfiler

@synthesize coordenada;


// Métodos a implementar
-(CLLocationCoordinate2D)coordinate {
    
    return coordenada;
    
    // Si tubiesemos que conectar a base de datos, aquí iría toda la lógica para entregar la coordenada
}

-(NSString *)title {
    return @"Por aquí le andas";
}

-(NSString *)subtitle {
    return @"Te hemos encontrado";
}










@end
