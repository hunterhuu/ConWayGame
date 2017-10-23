//
//  ConWayGOFViewController.m
//  OCTest
//
//  Created by developer on 2017/10/19.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "ConWayGOFViewController.h"
#import "ConWayGOF.h"

@interface ConWayGOFViewController ()

@property (nonatomic, strong) ConWayGOF *conwayGame;

@end

@implementation ConWayGOFViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.conwayGame = [[ConWayGOF alloc] init];
    ConWayGOFBGView *gameView = [self.conwayGame creatConWayGOfWithSize:self.view.frame.size.width row:100];
    
    [self.view addSubview:gameView];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, self.view.frame.size.width + 30, self.view.frame.size.width - 100, 50)];
    [button1 setTitle:@"play" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self.conwayGame action:@selector(ConWayGOFPlayBall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    CGRect tempFrame = button1.frame;
    tempFrame.origin.y += 50;
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:tempFrame];
    [button2 setTitle:@"pause" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 addTarget:self.conwayGame action:@selector(ConWayGOFPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    tempFrame.origin.y += 50;
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:tempFrame];
    [button3 setTitle:@"reset" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button3 addTarget:self.conwayGame action:@selector(ConWayGOFReset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
