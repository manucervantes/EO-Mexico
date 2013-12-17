//
//  Miembros.h
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Miembros : UIViewController <UITableViewDelegate,UITableViewDelegate>{
    NSMutableArray *tableViewData;
}
@property (strong, nonatomic) IBOutlet UITableView *contenedor;
@property (retain,nonatomic)   NSMutableArray *tableViewData;

@end
