//
//  Editar_perfil.m
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 11/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Editar_perfil.h"
#import <Parse/Parse.h>
#import "Perfil.h"

@interface Editar_perfil ()

@end

@implementation Editar_perfil
@synthesize nombre_txt,puesto_txt,empresa_txt,ciudad_txt,enviar,datos,imageView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cargar_datos];
}
-(void)viewDidAppear:(BOOL)animated {
    [self actualizar_txtbutton];
    nombre_txt.delegate = self;
    puesto_txt.delegate = self;
    empresa_txt.delegate = self;
    ciudad_txt.delegate = self;

}
-(IBAction)trasladar{
    [UIView beginAnimations:@"advancedAnimations" context:nil];
    [UIView setAnimationDuration:0.7];
    datos.alpha = 1.0;
    CGRect frame_datos = datos.frame;
    frame_datos.origin.x = 0;
    frame_datos.origin.y = 3;
    datos.frame = frame_datos;
    [UIView commitAnimations];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)TakePhoto{
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self  presentViewController:picker animated:YES completion:NULL];
}

-(void)Existente{
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self  presentViewController:picker2 animated:YES completion:NULL];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info  {
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)fotho{
    UIAlertView *alert_photo  = [[UIAlertView alloc ] initWithTitle:@"Tomar Foto" message:@"selecciona el origen de tu foto" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Del dispositivo",@"De la camara", nil];
    [alert_photo show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex  == 1){
        [self Existente];
    }
    else if (buttonIndex == 2){
        [self TakePhoto];
    }
}
- (IBAction)updateprofile {
    NSString *nombre;
    NSString *puesto;
    NSString *empresa;
    NSString *ciudad;
    nombre = nombre_txt.text;
    puesto  = puesto_txt.text;
    empresa = empresa_txt.text;
    ciudad = ciudad_txt.text;
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Perfil"];
    [query whereKey:@"User" equalTo: user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count == 0) {
                NSData *imageDatafile  = UIImageJPEGRepresentation(image, 300);
                PFFile *imageFile  = [PFFile fileWithName:@"photo" data:imageDatafile];
                PFObject *perfil = [PFObject objectWithClassName:@"Perfil"];
                perfil[@"nombre"] = nombre;
                perfil[@"puesto"] = puesto;
                perfil[@"empresa"] = empresa;
                perfil[@"ciudad"] = ciudad;
                perfil[@"User"] = user;
                perfil[@"foto"] = imageFile;
                [perfil saveInBackground];
                [self cambiarPantalla];
                
            }
            else{
                NSData *imageDatafile  = UIImagePNGRepresentation(image);
                PFFile *imageFile  = [PFFile fileWithName:@"photo" data:imageDatafile];
                [enviar setTitle:@"Actualizar" forState:UIControlStateNormal];
                [objects objectAtIndex:0][@"foto"] = imageFile;
                [objects objectAtIndex:0][@"nombre"] = nombre;
                [objects objectAtIndex:0][@"puesto"] = puesto;
                [objects objectAtIndex:0][@"empresa"] = empresa;
                [objects objectAtIndex:0][@"ciudad"] = ciudad;
                [objects objectAtIndex:0][@"User"] = user;
                [[objects objectAtIndex:0] saveInBackground];
                [self    cambiarPantalla];
            }
                    } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
    
    
    
    
}
- (IBAction)cerrarTeclao:(id)sender {
    [nombre_txt resignFirstResponder];
    [puesto_txt resignFirstResponder];
    [empresa_txt resignFirstResponder];
    [ciudad_txt resignFirstResponder];
    [self   regresarframe];
}


- (void)killScroll :(UIScrollView*)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    offset.x -= 1.0;
    offset.y -= 1.0;
    [scrollView setContentOffset:offset animated:NO];
    offset.x += 1.0;
    offset.y += 1.0;
    [scrollView setContentOffset:offset animated:NO];
}

-(void)actualizar_txtbutton{
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Perfil"];
    [query whereKey:@"User" equalTo: user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count == 0) {
                [enviar setTitle:@"Crear" forState:UIControlStateNormal];
            }
            else{
                [enviar setTitle:@"Actualizar" forState:UIControlStateNormal];
            }
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

}

- (IBAction)regresar:(id)sender {
    [self   cambiarPantalla];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
     if (textField == puesto_txt){
        [self trans_puesto];
    }
    else if (textField == empresa_txt){
        [self trans_empresa];
        
    }else if(textField == ciudad_txt)
    {
        [self trans_ciudad];
    }
}
-(void)regresarframe{
    [UIView beginAnimations:@"advancedAnimations" context:nil];
    [UIView setAnimationDuration:0.7];
    datos.alpha = 1.0;
    CGRect frame_datos = datos.frame;
    frame_datos.origin.x = 0;
    frame_datos.origin.y = 0;
    datos.frame = frame_datos;
    [UIView commitAnimations];
}

-(void)trans_puesto{
    [UIView beginAnimations:@"advancedAnimations" context:nil];
    [UIView setAnimationDuration:0.7];
    datos.alpha = 1.0;
    CGRect frame_datos = datos.frame;
    frame_datos.origin.x = 0;
    frame_datos.origin.y = -20;
    datos.frame = frame_datos;
    [UIView commitAnimations];  
}
-(void)trans_empresa{
    [UIView beginAnimations:@"advancedAnimations" context:nil];
    [UIView setAnimationDuration:0.7];
    datos.alpha = 1.0;
    CGRect frame_datos = datos.frame;
    frame_datos.origin.x = 0;
    frame_datos.origin.y = -60;
    datos.frame = frame_datos;
    [UIView commitAnimations];
}
-(void)trans_ciudad{
    [UIView beginAnimations:@"advancedAnimations" context:nil];
    [UIView setAnimationDuration:0.7];
    datos.alpha = 1.0;
    CGRect frame_datos = datos.frame;
    frame_datos.origin.x = 0;
    frame_datos.origin.y = -140;
    datos.frame = frame_datos;
    [UIView commitAnimations];
}
- (void) cambiarPantalla{
    Perfil *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"perfil"];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)cargar_datos{
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Perfil"];
    [query whereKey:@"User" equalTo: user];
    [query  findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            for (PFObject *object in objects ) {
                NSString *nombre = [object objectForKey:@"nombre"];
                NSString *puesto = [object objectForKey:@"puesto"];
                NSString *empresa = [object objectForKey:@"empresa"];
                NSString *ciudad = [object objectForKey:@"ciudad"];
                nombre_txt.text = nombre;
                puesto_txt.text = puesto;
                empresa_txt.text = empresa;
                ciudad_txt.text = ciudad;
                PFFile *theimage =[object objectForKey:@"foto"];
                [theimage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    NSData *imagedata = data;
                    UIImage *imagen = [UIImage imageWithData:imagedata];
                    imageView.image = imagen;
                }];
            }
        }
        else{
            NSLog(@"Parse Error %@",error);
        }
    }];
    
}

@end
