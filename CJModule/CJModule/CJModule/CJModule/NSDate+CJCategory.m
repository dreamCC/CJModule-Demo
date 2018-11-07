//
//  NSDate+CJCategory.m
//  CommonProject
//
//  Created by 仁和Mac on 2018/1/25.
//  Copyright © 2018年 zhucj. All rights reserved.
//

#import "NSDate+CJCategory.h"

@implementation NSDate (CJConvert)

-(NSString *)cj_toString {
    NSDateComponents *componpents = [self cj_toComponents];
    return [NSString stringWithFormat:@"%zd-%zd-%zd %02zd:%02zd:%02zd",componpents.year,componpents.month,componpents.day,componpents.hour,componpents.minute,componpents.second];
}

-(NSDateComponents *)cj_toComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componpents = [calendar components:NSCalendarUnitYear   |
                                     NSCalendarUnitMonth  |
                                     NSCalendarUnitDay    |
                                     NSCalendarUnitHour   |
                                     NSCalendarUnitMinute |
                                     NSCalendarUnitSecond
                                                fromDate:self];
    return componpents;
}

-(NSDateComponents *)cj_dateComponents {
    return [self cj_toComponents];
}

-(NSInteger)cj_year {
    return self.cj_dateComponents.year;
}

-(NSInteger)cj_month {
    return self.cj_dateComponents.month;
}

-(NSInteger)cj_day {
    return self.cj_dateComponents.day;
}

-(NSInteger)cj_hour {
    return self.cj_dateComponents.hour;
}

-(NSInteger)cj_minute {
    return self.cj_dateComponents.minute;
}

-(NSInteger)cj_second {
    return self.cj_dateComponents.second;
}
@end
