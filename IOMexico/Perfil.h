//
//  Perfil.h
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Perfil : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UILabel *nombre;
@property (strong, nonatomic) IBOutlet UILabel *empresa;
@property (strong, nonatomic) IBOutlet UILabel *ciudad;
@property (strong, nonatomic) IBOutlet UILabel *puesto;

@end
