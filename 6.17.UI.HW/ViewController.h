//
//  ViewController.h
//  6.17.UI.HW
//
//  Created by rimi on 15/6/17.
//  Copyright (c) 2015年 rectinajh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *lastSong;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *nextSong;
@property (weak, nonatomic) IBOutlet UILabel *MusicName;

@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@end

