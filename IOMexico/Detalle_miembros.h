//
//  Detalle_miembros.h
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 17/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detalle_miembros : UIViewController
@property (copy,readwrite) NSString *ides;
@property (strong, nonatomic) IBOutlet UILabel *puesto;
@property (strong, nonatomic) IBOutlet UILabel *nombre;
@property (strong, nonatomic) IBOutlet UILabel *empresa;
@property (strong, nonatomic) IBOutlet UILabel *ciudad;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;

@end
