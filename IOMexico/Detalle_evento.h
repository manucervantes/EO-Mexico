//
//  Detalle_evento.h
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 13/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detalle_evento : UIViewController
@property (retain,nonatomic)   NSString *algo;
@property (copy,readwrite) NSString *ides;
@property (strong, nonatomic) IBOutlet UILabel *texto;
@property (strong, nonatomic) IBOutlet UILabel *fecha_inc;
@property (strong, nonatomic) IBOutlet UILabel *fecha_fin;
@property (strong, nonatomic) IBOutlet UITextView *contenido;

@end

