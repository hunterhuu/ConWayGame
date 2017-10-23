//
//  ConWayGOF.m
//  OCTest
//
//  Created by developer on 2017/10/19.
//  Copyright © 2017年 developer. All rights reserved.
//

#import "ConWayGOF.h"

typedef struct  {
    NSInteger index_X;
    NSInteger Index_Y;
} ArrayIndexCount;

@implementation ConWayGOF


- (instancetype)init {
    self = [super init];
    if (self) {
        ;
    }
    
    return self;
}

- (ConWayGOFBGView *)creatConWayGOfWithSize:(CGFloat) size row:(NSInteger) row {
    
    self.row = row;
    self.BGView = [[ConWayGOFBGView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    self.BGView.row = row;
    self.BGView.cellSize = size / row;
    
    self.oldDataArray = [[NSMutableArray alloc] initWithCapacity:row * row];
    
    for (int i = 0; i < row * row; i++) {
        self.oldDataArray[i] = @0;
    }
    
    self.gameDate = [[NSMutableArray alloc] initWithArray:self.oldDataArray];
    
//    self.gameDate[4101] = @1;
//    self.gameDate[4104] = @1;
//    self.gameDate[4205] = @1;
//    self.gameDate[4301] = @1;
//    self.gameDate[4305] = @1;
//    self.gameDate[4402] = @1;
//    self.gameDate[4403] = @1;
//    self.gameDate[4404] = @1;
//    self.gameDate[4405] = @1;

    self.BGView.gameDate = self.gameDate;
    
    return self.BGView;
}
- (void)ConWayGOFPlayBall {
    if (self.gameTimer == nil) {
        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(gameOneStepGO) userInfo:nil repeats:YES];
    }
    
}
- (void)ConWayGOFPause {
    
    NSLog(@"pause");
    
    [self.gameTimer invalidate];
    self.gameTimer = nil;
}
- (void)ConWayGOFReset {
    self.gameDate = [NSMutableArray arrayWithArray:self.oldDataArray];
    self.BGView.gameDate = self.gameDate;
    [self.BGView viewRefresh];
    [self.gameTimer invalidate];
    self.gameTimer = nil;
    
    NSLog(@"reset");
    
}

- (void)gameOneStepGO {
    NSMutableArray *newGameArray = [[NSMutableArray alloc] initWithArray:self.oldDataArray];
    
    NSLog(@"go one setp");
    
    for (int i = 0; i < self.gameDate.count; i++) {
        if ([self checkCellNextStepIsLive:i]) {
            newGameArray[i] = @1;
        } else {
            newGameArray[i] = @0;
        }
    }
    
    self.gameDate = nil;
    self.gameDate = newGameArray;
    self.BGView.gameDate = newGameArray;
    [self.BGView viewRefresh];
}

- (BOOL)checkCellNextStepIsLive:(NSInteger) dataIndex {
 
    NSInteger countNum = 0;
    
    NSArray<NSNumber *> *tempIndex = @[@(dataIndex - self.row - 1),
                           @(dataIndex - self.row),
                           @(dataIndex - self.row + 1),
                           @(dataIndex - 1),
                           @(dataIndex + 1),
                           @(dataIndex + self.row - 1),
                           @(dataIndex + self.row),
                           @(dataIndex + self.row + 1),
                           ];

    for (int k = 0; k < tempIndex.count; k++) {
        if (![self checkCellIsOutOfRange:tempIndex[k].integerValue] && [self checkCellIsOne:tempIndex[k].integerValue]) {
            countNum ++;
        }
    }
    
    if ([self.gameDate[dataIndex] isEqual:@1]) {
        if (countNum < 2 || countNum > 3) {
            return NO;
        } else {
            return YES;
        }
    } else {
        if (countNum == 3) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}

- (BOOL)checkCellIsOutOfRange:(NSInteger) dataIndex {

    ArrayIndexCount ArrayIndex = [self changeOneToTwo:dataIndex];
    
    if (ArrayIndex.index_X < 0 || ArrayIndex.index_X >= self.row || ArrayIndex.Index_Y < 0 || ArrayIndex.Index_Y >= self.row) {
        return YES;
    }
    
    return NO;
}

- (BOOL)checkCellIsOne:(NSInteger) dataIndex {
        if ([self.gameDate[dataIndex] isEqual:@1]) {
        return YES;
    }
    return NO;
}


- (ArrayIndexCount) changeOneToTwo:(NSInteger) oneIndex {
    
    ArrayIndexCount twoIndex = {oneIndex / self.row, oneIndex % self.row};
    
    return twoIndex;
}

- (NSInteger) changeTwoToOne:(ArrayIndexCount) twoIndex {
    return twoIndex.Index_Y * self.row + twoIndex.index_X;
}
@end

#pragma mark -

@implementation ConWayGOFBGView

- (void)viewRefresh {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < self.gameDate.count; i++) {
        
        NSInteger pointX = i % self.row;
        NSInteger pointY = i / self.row;
        
        UIColor *drawColor = ([self.gameDate[i] isEqual: @0] ? [UIColor greenColor] : [UIColor redColor]);
        
        [self drawCellWithContext:context onPointX:pointX * self.cellSize onPointY:pointY * self.cellSize WithColor:drawColor];
    }
}

- (void)drawCellWithContext:(CGContextRef) context onPointX:(CGFloat)pointX onPointY: (CGFloat)PointY WithColor:(UIColor *)darwColor {
    
    CGContextAddRect(context, CGRectMake(pointX, PointY, self.cellSize + 1, self.cellSize + 1));
    [darwColor set];
    
    CGContextFillPath(context);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint point = [touch locationInView:touch.view];
    
    NSInteger index = (NSInteger)(point.x / self.cellSize) + (NSInteger)(point.y / self.cellSize) * self.row;

    self.gameDate[index] = [self.gameDate[index] isEqual:@0] ? @1 : @0;

//    NSLog(@"point = %ld, %ld,  index = %ld", (NSInteger)point.x, (NSInteger)poin t.y, (NSInteger)index);
    
    [self setNeedsDisplay];
    
}

@end
