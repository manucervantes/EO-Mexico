//
//  Detalle_noticia.h
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 17/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detalle_noticia : UIViewController
@property (copy,readwrite) NSString *ides;
@property (strong, nonatomic) IBOutlet UIImageView *imagen;
@property (strong, nonatomic) IBOutlet UILabel *titulo;
@property (strong, nonatomic) IBOutlet UITextView *mensaje;

@end
