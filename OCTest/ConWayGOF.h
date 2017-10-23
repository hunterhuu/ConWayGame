//
//  ConWayGOF.h
//  OCTest
//
//  Created by developer on 2017/10/19.
//  Copyright © 2017年 developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ConWayGOFBGView;

@interface ConWayGOF : NSObject

@property (nonatomic, strong) ConWayGOFBGView *BGView;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *oldDataArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *gameDate;
@property (nonatomic, strong) NSTimer *gameTimer;
@property (nonatomic, assign) NSInteger row;

- (instancetype)init;

- (ConWayGOFBGView *)creatConWayGOfWithSize:(CGFloat) size row:(NSInteger) row;
- (void)ConWayGOFPlayBall;
- (void)ConWayGOFPause;
- (void)ConWayGOFReset;
@end

#pragma mark -

@interface ConWayGOFBGView : UIView

@property (nonatomic, assign) CGFloat cellSize;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *gameDate;

- (void)viewRefresh;

@end


