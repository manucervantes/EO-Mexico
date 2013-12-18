//
//  Editar_perfil.h
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 11/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Editar_perfil : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>{
    
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    IBOutlet UIImageView *imageView;
    
}
@property (strong, nonatomic) IBOutlet UITextField *nombre_txt;
@property (strong, nonatomic) IBOutlet UITextField *empresa_txt;
@property (strong, nonatomic) IBOutlet UITextField *puesto_txt;
@property (strong, nonatomic) IBOutlet UITextField *ciudad_txt;
@property (strong, nonatomic) IBOutlet UIButton *enviar;

-(IBAction)TakePhoto;
-(IBAction)Existente;
-(IBAction)updateprofile;


@end
