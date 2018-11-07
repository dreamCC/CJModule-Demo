//
//  CJPickerContainerDateView.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/3/12.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "CJPickerContainerDate.h"

static NSString *const kYearOffset    = @"kYearOffset";
static NSString *const kMonthOffset   = @"kMonthOffset";
static NSString *const kDayOffset     = @"kDayOffset";
static NSString *const kHourOffset    = @"kHourOffset";
static NSString *const kMinuteOffset  = @"kMinuteOffset";
static NSString *const kSecondeOffset = @"kSecondeOffset";


@interface CJPickerContainerDate ()

/// date的类型
@property(nonatomic, assign, readwrite) CJPickerContainerDateMode dateMode;

/// 日期
@property(nonatomic, strong, readwrite) NSDate *date;

@property(nonatomic,strong) NSArray *yearList;

@property(nonatomic,strong) NSArray *monthList;

@property(nonatomic,strong) NSArray *dayList;

@property(nonatomic,strong) NSArray *hourList;

@property(nonatomic,strong) NSArray *minuteList;

@property(nonatomic,strong) NSArray *secondeList;

@property(nonatomic, strong) NSDateComponents *maximumComponents;

@property(nonatomic, strong) NSDateComponents *minimumComponents;

@property(nonatomic, strong) NSDateComponents *currentComponents;

@property(nonatomic, assign) NSCalendarUnit supportUnits;

@property(nonatomic, strong) NSMutableDictionary *dateOffset;

/// 选中的信息
@property(nonatomic, strong) NSMutableArray *mSelectInfo;
@end

@implementation CJPickerContainerDate

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    NSArray *keyIndex = @[kYearOffset,kMonthOffset,kDayOffset,kHourOffset,kMinuteOffset,kSecondeOffset];
    for (int i = 0; i <= self.dateMode; i++) {
        [self.pikerView selectRow:[[self.dateOffset valueForKey:keyIndex[i]] integerValue] inComponent:i animated:NO];
    }
}

-(instancetype)initWithStyle:(CJPickerContainerViewStyle)style date:(NSDate *)currentDate mode:(CJPickerContainerDateMode)mode{
    self = [super initWithStyle:style];
    if (self) {
        self.date        = currentDate;
        self.dayList     = [self getDaysListFromeDate:currentDate];
        self.currentComponents = [[NSCalendar currentCalendar] components:self.supportUnits fromDate:currentDate];

        self.dateMode    = mode;
        self.maximunDate = [NSDate distantFuture];
        self.minimunDate = [NSDate distantPast];
        
    }
    return self;
}



-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearList.count;
    }else if (component == 1) {
        return self.monthList.count;
    }else if (component == 2) {
        return self.dayList.count;
    }else if (component == 3) {
        return self.hourList.count;
    }else if (component == 4) {
        return self.minuteList.count;
    }else if (component == 5) {
        return self.secondeList.count;
    }

    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
   
    return self.dateMode + 1;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSAttributedString *attrString;
    NSDictionary *attributesDic = @{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize],
                                    NSForegroundColorAttributeName:self.fontColor
                                    };
    if (component == 0) {
        attrString = [[NSAttributedString alloc] initWithString:self.yearList[row] attributes:attributesDic];
    }else if (component == 1) {
        attrString = [[NSAttributedString alloc] initWithString:self.monthList[row] attributes:attributesDic];
    }else if (component == 2) {
        attrString = [[NSAttributedString alloc] initWithString:self.dayList[row] attributes:attributesDic];
    }else if (component == 3) {
        attrString = [[NSAttributedString alloc] initWithString:self.hourList[row] attributes:attributesDic];
    }else if (component == 4) {
        attrString = [[NSAttributedString alloc] initWithString:self.minuteList[row] attributes:attributesDic];
    }else if (component == 5) {
        attrString = [[NSAttributedString alloc] initWithString:self.secondeList[row] attributes:attributesDic];
    }

    UILabel *lab = [UILabel new];
    lab.textAlignment  = NSTextAlignmentCenter;
    lab.attributedText = attrString;
    return lab;
  
}



-(void)sureItemClick:(UIBarButtonItem *)sureItem {
    if ([self.delegate respondsToSelector:@selector(cj_pickerContainerView:didFinishWithInfo:)]) {
        [self.mSelectInfo removeAllObjects];
        NSArray<NSArray *> *sourceArys = @[self.yearList,self.monthList,self.dayList,self.hourList,self.minuteList,self.secondeList];
        for (int i = 0; i <= _dateMode; i++) {
            NSArray *sources = sourceArys[i];
            NSInteger row = [self.pikerView selectedRowInComponent:i];
            [self.mSelectInfo addObject:sources[row]];
        }
        [self.delegate cj_pickerContainerView:self didFinishWithInfo:self.mSelectInfo];
    }
}

#pragma mark ---- private method
-(NSArray *)getDaysListFromeDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    NSMutableArray *mDays = @[].mutableCopy;
    for (int i = 1; i <= days; i++) {
        @autoreleasepool {
            NSString *day = [NSString stringWithFormat:@"%02d日",i];
            [mDays addObject:day];
        }
    }
    return [NSArray arrayWithArray:mDays];
}

-(void)fetchOffsetFromComponents:(NSDateComponents *)components{
    NSInteger yearOffset   = self.currentComponents.year - components.year ?:0;
    NSInteger monthOffset  = self.currentComponents.month - 1;
    NSInteger dayOffset    = self.currentComponents.day - 1;
    NSInteger hourOffset   = self.currentComponents.hour - 1;
    NSInteger minuteOffset = self.currentComponents.minute - 1;
    NSInteger secendOffset = self.currentComponents.second - 1;
    [self.dateOffset setValue:@(yearOffset) forKey:kYearOffset];
    [self.dateOffset setValue:@(monthOffset) forKey:kMonthOffset];
    [self.dateOffset setValue:@(dayOffset) forKey:kDayOffset];
    [self.dateOffset setValue:@(hourOffset) forKey:kHourOffset];
    [self.dateOffset setValue:@(minuteOffset) forKey:kMinuteOffset];
    [self.dateOffset setValue:@(secendOffset) forKey:kSecondeOffset];
}

#pragma mark ---- setter && getter
-(void)setMinimunDate:(NSDate *)minimunDate {
    _minimunDate = minimunDate;
    NSCalendar *calendar   = [NSCalendar currentCalendar];
    self.minimumComponents = [calendar components:self.supportUnits fromDate:_minimunDate];
    [self fetchOffsetFromComponents:self.minimumComponents];
}

-(void)setMaximunDate:(NSDate *)maximunDate {
    _maximunDate = maximunDate;
    NSCalendar *calendar   = [NSCalendar currentCalendar];
    self.maximumComponents = [calendar components:self.supportUnits fromDate:_maximunDate];
}


#pragma mark ---- lazy
-(NSArray *)yearList {
    if (!_yearList) {
        NSInteger min, max;
        min = self.minimumComponents.year;
        max = self.maximumComponents.year;
        
        NSMutableArray *mYears = @[].mutableCopy;
        for (NSInteger i = min; i <= max; i++) {
            @autoreleasepool {
                NSString *year = [NSString stringWithFormat:@"%zd年",i];
                [mYears addObject:year];
            }
        }
        
        _yearList = [NSArray arrayWithArray:mYears];
    }
    return _yearList;
}

-(NSArray *)monthList {
    if (!_monthList) {
        NSMutableArray *mMonths = @[].mutableCopy;
        for (int i = 1; i < 13; i++) {
            NSString *month = [NSString stringWithFormat:@"%d月",i];
            [mMonths addObject:month];
        }
        
        _monthList = [NSArray arrayWithArray:mMonths];
    }
    return _monthList;
}

-(NSArray *)hourList {
    if (!_hourList) {
        NSMutableArray *mHours = @[].mutableCopy;
        for (int i = 0; i < 24; i++) {
            @autoreleasepool {
                NSString *hour = [NSString stringWithFormat:@"%02d时",i];
                [mHours addObject:hour];
            }
        }
        
        _hourList = [NSArray arrayWithArray:mHours];
    }
    return _hourList;
}

-(NSArray *)minuteList {
    if (!_minuteList) {
        NSMutableArray *mMinutes = @[].mutableCopy;
        for (int i = 0; i < 60; i++) {
            @autoreleasepool {
                NSString *minute = [NSString stringWithFormat:@"%02d分",i];
                [mMinutes addObject:minute];
            }
        }
        
        _minuteList = [NSArray arrayWithArray:mMinutes];
    }
    return _minuteList;
}


-(NSArray *)secondeList {
    if (!_secondeList) {
        NSMutableArray *mSecondes = @[].mutableCopy;
        for (int i = 0; i < 60; i++) {
            @autoreleasepool {
                NSString *seconde = [NSString stringWithFormat:@"%02d秒",i];
                [mSecondes addObject:seconde];
            }
        }
        
        _secondeList = [NSArray arrayWithArray:mSecondes];
    }
    return _secondeList;
}

-(NSCalendarUnit)supportUnits {
    if (!_supportUnits) {
        _supportUnits = NSCalendarUnitYear  |
                        NSCalendarUnitMonth |
                        NSCalendarUnitDay   |
                        NSCalendarUnitHour  |
                        NSCalendarUnitMinute|
                        NSCalendarUnitSecond;
    }
    return _supportUnits;
}

-(NSMutableDictionary *)dateOffset {
    if (!_dateOffset) {
        _dateOffset = [NSMutableDictionary dictionary];
    }
    return _dateOffset;
}

-(NSMutableArray *)mSelectInfo {
    if (!_mSelectInfo) {
        _mSelectInfo = [NSMutableArray array];
    }
    return _mSelectInfo;
}

@end
