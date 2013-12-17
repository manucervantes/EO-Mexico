//
//  Noticias.h
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 12/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Noticias : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *tableViewData;
    NSMutableArray *tableIdViewData;

}

@property (strong, nonatomic) IBOutlet UITableView *contenedor;
@property (retain,nonatomic)   NSMutableArray *tableViewData;
@property (retain,nonatomic)   NSMutableArray *tableIdViewData;
@property (strong, nonatomic) IBOutlet UIButton *regresar;

@end
