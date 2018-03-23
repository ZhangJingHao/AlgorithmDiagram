//
//  ViewController.m
//  AlgorithmDiagram
//
//  Created by ZhangJingHao2345 on 2018/3/19.
//  Copyright © 2018年 ZhangJingHao2345. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *nameArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.nameArr = @[@"1、二分查找",
                     @"2、选择排序",
                     @"3、快速排序"
                     ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_Id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_Id];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.nameArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: { // 1、二分查找
            NSArray *arr = @[@1,@2,@3,@4,@5,@6,@7,@9];
            NSUInteger result = [self binarySearchWithArr:arr andTarget:5];
            NSLog(@"%ld",result);
        }
            break;
        case 1:{ // 2、选择排序
            NSArray *arr = @[@1, @2, @4, @3, @9, @5, @3];
            NSLog(@"选择排序 前 ：%@", arr);
            NSArray *sortArr = [self selectionSortWithArr:arr];
            NSLog(@"选择排序 后 ：%@", sortArr);
        }
            break;
        case 2: { // 3、快速排序 6 1 2 7 9 3 4 5 10 8
            NSMutableArray *arr = @[@6,@1,@2,@7,@9,@3,@4,@5,@10,@8].mutableCopy;
            NSLog(@"快速排序 前 ：%@", arr);
            [self quickSortWithArr:arr leftIndex:0 rightIndex:arr.count -1];
            NSLog(@"快速排序 后 ：%@", arr);
        }
            break;
        case 3: {
            
        }
            break;
        case 4: {
            
        }
            break;
        case 5: {
            
        }
            break;
        case 6: {
            
        }
            break;
        case 7: {
            
        }
            break;
        case 8: {
            
        }
            break;
        case 9: {
            
        }
            break;
        case 10: {
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - 1、二分查找
// 1、二分查找
- (NSUInteger)binarySearchWithArr:(NSArray *)arr andTarget:(NSInteger)target {
    if (!arr.count) {
        return -1;
    }
    
    NSUInteger low = 0;
    NSUInteger high = arr.count - 1;
    
    while (low <= high) {
        // 会有一些朋友看到有些人是( low + high ) / 2这样写的
        // 但low+high会出现整数溢出的情况,如果存在溢出,你再除以2也是没有用的
        NSUInteger mid = low + (high - low)/2;
        // 第mid项的内容
        NSInteger num = [arr[mid] integerValue];
        
        if (target == num) {
            return mid; // 返回对应位置
        } else if (num > target) {
            high = mid - 1; // 左边进行查找
        } else {
            low = mid + 1; // 右边进行查找
        }
    }
    
    // 返回-1是没找到
    return -1;
}

#pragma mark - 2、选择排序
// 2、选择排序
- (NSArray *)selectionSortWithArr:(NSArray *)arr {
    NSMutableArray *sortArr = [NSMutableArray arrayWithArray:arr];
    NSInteger min = 0;
    
    // 进行N-1轮选择
    for (NSInteger i = 0; i < sortArr.count; i++) {
        min = i; // 先假设最小下标为i
        
        //找出第i小的数所在的位置
        for (NSInteger j = i + 1; j < sortArr.count; j++) {
            if ([sortArr[j] integerValue] < [sortArr[min] integerValue]) {
                min = j;
            }
        }
        
        // 将第i小的数，放在第i个位置；如果刚好，就不用交换
        if (min != i) {
            id temp = sortArr[i];
            sortArr[i] = sortArr[min];
            sortArr[min] = temp;
        }
    }
    return sortArr;
}

#pragma mark - 3、快速排序
// 3、快速排序
- (void)quickSortWithArr:(NSMutableArray *)array
               leftIndex:(NSInteger)leftIndex
              rightIndex:(NSInteger)rightIndex {
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    // 记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        // 顺序很重要，要先从右边开始找
        while (i < j && [array[j] integerValue] >= key) {
            j--;
        }
        
        // 再找左边的
        while (i < j && [array[i] integerValue] <= key) {
            i++;
        }
        
        // 交换两个数在数组中的位置
        if (i < j) {
            id t = array[i];
            array[i] = array[j];
            array[j] = t;
        }
    }
    
    // 最终将基准数归位
    array[leftIndex] = array[i];
    array[i] = @(key);
    
    // 递归排序: 排序基准数左边的
    [self quickSortWithArr:array leftIndex:leftIndex rightIndex:i-1];
    // 递归排序: 排序基准数右边的
    [self quickSortWithArr:array leftIndex:i+1 rightIndex:rightIndex];
}

@end
