//
//  BPVObservableObject.h
//  BPVObjectiveC
//
//  Created by Bondar Pavel on 6/27/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BPVObservableObjectProtocol.h"

@interface BPVObservableObject : NSObject <BPVObservableObject>

+ (instancetype)observableObjectWithTarget:(id)target;

@end
