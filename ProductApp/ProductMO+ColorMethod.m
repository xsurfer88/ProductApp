//
//  ProductMO+ColorMethod.m
//  ProductApp
//
//  Created by Yang Zi on 9/15/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductMO+ColorMethod.h"
#import "Color.h"

@implementation ProductMO (ColorMethod)

- (void)insertColorWithDictionary:(NSDictionary *)colorDict ByContext:(NSManagedObjectContext *) curContext{
    
    Color *color = [NSEntityDescription insertNewObjectForEntityForName:@"Color"
                                                     inManagedObjectContext:curContext];
    
    [color setId:[colorDict objectForKey:@"id"]];
    [color setName:[colorDict objectForKey:@"name"]];
    
    NSError *error = nil;
    BOOL saved;
    saved = [curContext save:&error];
    if (!saved) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (Color *)getColorById:(NSNumber *)colorId ByContext:(NSManagedObjectContext *) curContext{
    NSArray *colors = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Color"];
    [request setSortDescriptors:[NSArray arrayWithObject:
                                 [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]]];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"id == %d",[colorId integerValue]];
    [request setPredicate:pred];
    NSError *error = nil;
    
    colors = [curContext executeFetchRequest:request error:&error];
    Color *color = [colors lastObject];
    
    return color;
}

@end
