//
//  ViewController.m
//  DKFPSCheck
//
//  Created by zhang dekai on 2019/12/9.
//  Copyright © 2019 zhang dekai. All rights reserved.
//

#import "ViewController.h"
#import "YYWeakProxy.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSTimeInterval lastTime;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _count = 0;
    _lastTime = 0;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:[YYWeakProxy weakProxyWithTarget:self] selector:@selector(displayFps:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [self addOnserver];
}

- (void)dealloc
{
    if (!_displayLink.isPaused) {
        [_displayLink setPaused:YES];
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

#pragma mark 方法一
- (void)displayTimer:(CADisplayLink *)link {//每秒调用60次
    
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count += 1;
    
    NSTimeInterval interval = link.timestamp - _lastTime;
    if (interval < 1) {
        return;
    }
    _lastTime = link.timestamp;
    float fps = _count / interval;
    _count = 0;
    
    _titleLabel.text = [NSString stringWithFormat:@"FPS:%.0f",fps];
    
    
    //    NSString *text = [NSString stringWithFormat:@"%d:FPS",(int)round(fps)];
    //
    //    _titleLabel.text = text;
    
    
}
#pragma mark 方法二

- (void)displayFps: (CADisplayLink *)fpsDisplay {
    self.count++;
    CFAbsoluteTime threshold = CFAbsoluteTimeGetCurrent() - _lastTime;
    if (threshold >= 1.0) {
        float fps = (_count / threshold);
        _lastTime = CFAbsoluteTimeGetCurrent();
        _titleLabel.text = [NSString stringWithFormat:@"FPS:%.0f",fps];
        self.count = 0;
        NSLog(@"count = %ld,_lastTime = %f, _fps = %.0f",_count, _lastTime, fps);
    }
}

- (void)addOnserver {
    [self addObserver:self forKeyPath:@"count" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"count new = %@, old = %@",[change valueForKey:@"new"], [change valueForKey:@"old"]);

}


#pragma tableView delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestFPSCell" forIndexPath:indexPath];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
   
    UITableViewCell *cell = [[UITableViewCell alloc]init];

    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float posX = 10;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 5, 40, 40)];
    imgView.image = [UIImage imageNamed:@"img1"];
    imgView.layer.cornerRadius = 20;
    imgView.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgView];
    posX = 70;
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 5, 40, 40)];
    imgView2.image = [UIImage imageNamed:@"img1"];
    imgView2.layer.cornerRadius = 20;
    imgView2.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgView2];
    posX = 130;
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 5, 40, 40)];
    imgView3.image = [UIImage imageNamed:@"img2"];
    imgView3.layer.cornerRadius = 20;
    imgView3.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgView3];
    posX = 190;
    
    
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 5, 40, 40)];
    imgView4.image = [UIImage imageNamed:@"img3"];
    imgView4.layer.cornerRadius = 20;
    imgView4.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgView4];
    posX = 250;
    
    UILabel *lbe = [[UILabel alloc] initWithFrame:CGRectMake(posX, 10, 0, 0)];
    lbe.text = [NSString stringWithFormat:@"山东科技从那时的农村拉拉纳能力按今年春节是哪里呢%ld",indexPath.row];
    [lbe sizeToFit];
    [cell.contentView addSubview:lbe];
    
    
    return cell;
    
}


@end
