//
//  ViewController.m
//  CustomizedNavigationController
//
//  Created by tianpengfei on 2017/6/18.
//  Copyright © 2017年 tianpengfei. All rights reserved.
//

#import "ViewController.h"
#import "OPPInterceptViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"拦截导航控制器的返回方法";
    
    self.data = @[@"OPP Push",@"AOP Push"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.row == 0){
    
        OPPInterceptViewController *interceptViewController = [[OPPInterceptViewController alloc] init];
        [self.navigationController pushViewController:interceptViewController animated:YES];
    }
}
@end
