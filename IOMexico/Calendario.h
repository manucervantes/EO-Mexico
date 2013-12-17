//
//  Calendario.h
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calendario : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *tableViewData;
    NSMutableArray *tableIdViewData;

   IBOutlet UIActivityIndicatorView *activityind;
    
}
@property (strong, nonatomic) IBOutlet UITableView *contenedor;
@property (retain,nonatomic)   NSMutableArray *tableViewData;
@property (retain,nonatomic)   NSMutableArray *tableIdViewData;



@end
