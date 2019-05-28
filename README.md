# TMSWeChat
IGListKit实现微信朋友圈

IGListKit应该有人耳闻，它最大的特点便是**基于数据驱动**的这样一个特性，我使用它的动机也是鉴于它的这种类似“**组装者**”的理念，**把同一组数据拆分成不同section，每个section维护着自己独立的单元格(cell)。**
![IGListKit实现朋友圈](https://upload-images.jianshu.io/upload_images/2172432-9a12e421c7c13f59.gif?imageMogr2/auto-orient/strip)

先放一张搜索IGListKit都会出现的架构图，我也会围绕这个架构图来叙述我的实现方式![](https://upload-images.jianshu.io/upload_images/2172432-afe299de7eea4e75.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

+ ViewController是一个包含CollectionView的容器，在这个VC中需要关联CollectionView和Adapter。
```
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@([UIApplication sharedApplication].statusBarFrame.size.height+44));
    }];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
```
+ 在完成关联之后，接下来需要对每条数据进行拆分，我这里把一条数据拆分成了两个SectionController
![](https://upload-images.jianshu.io/upload_images/2172432-bf83667dbc06e5ba.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

让**评论区**独立成为一个SectionController也是受上边那篇文章的启发，根据上边的那张IGListKit架构图，SectionController是包含cell的，如果让两个SectionController合并成一个SectionController，当评论数过多时，对于评论处cell的高度计算则显得尤为麻烦，因为这样做需要计算其整体高度，而将评论区拆分成独立的SectionController，我们需要计算的仅仅是每一条评论的高度，无需关心整个评论区的高度，而且这个高度也是每个SectionController需要实现的方法`- (CGSize)sizeForItemAtIndex:(NSInteger)index;`，形同于UITableView的`- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;`

+ 拆分完成后，使用cell“装填”每个SectionController

+ 最后再配合ViewModel去完成数据的展示

[简书详情介绍](https://www.jianshu.com/p/d52fe7059d92)

