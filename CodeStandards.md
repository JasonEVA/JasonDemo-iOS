# Arthas iOS代码规范

## 条件语句

### 语句体总是使用大括号来包围避免错误。

推荐

```
if (!error) {
   return success;
}
```   

	 
不推荐

```
if (!error)
return success;
或者
if (!error) return success;
```	

### 不要使用尤达表达式（尤达表达式：使用常量去和变量比较）

推荐

```
if ([myValue isEqual:@42]) { ...
```

不推荐

```
if ([@42 isEqual:myValue]) { ...
```	
	
### nil和BOOL检查使用感叹号`！`来判断	
因为`nil`是解释到`NO`所以没必要在条件语句里面把它和其他值比较。同时，不要直接把它和`YES`比较，因为`YES`的定义是`1`而`BOOL`是8位的，实际上是`char`类型。
	
推荐

```
if (someObject) { ...
if (![someObject boolValue]) { ...
if (!someObject) { ...
	```
	不推荐
	
	```
if (someObject == YES) { ... // Wrong
if (myRawValue == YES) { ... // Never do this.
if ([someObject boolValue] == NO) { ...
```
	
### 不要嵌套`if`语句，多个`return`是OK的

推荐

```
- (void)someMethod {
  if (![someOther boolValue]) {
      return;
  }
 
  //Do something important
}

```

不推荐

```
- (void)someMethod {
  if ([someOther boolValue]) {
    //Do something important
  }
}
```

### 当遇到复杂的`if`语句时，应该将他们提取出来赋给给一个Bool变量

推荐

```
BOOL nameContainsSwift  = [sessionName containsString:@"Swift"];
BOOL isCurrentYear      = [sessionDateCompontents year] == 2014;
BOOL isSwiftSession     = nameContainsSwift && isCurrentYear;
 
if (isSwiftSession) {
    // Do something very cool
}
```

### 三元运算符`?:`,应该只用在它能让代码更加清晰的地方

推荐

```
result = a > b ? x : y;

result = object ? : [self createObject]; // 第二个参数返回和条件语句中已经检查的对象一致时
```

不推荐

```
result = a > b ? x = c > d ? c : d : y;

result = object ? object : [self createObject]; // 第二个参数返回和条件语句中已经检查的对象一致时
```

### 当方法返回一个错误参数引用的时候，检查返回值，而不是错误的变量

推荐

```
NSError *error = nil;
if (![self trySomethingWithError:&error]) {
    // Handle Error
}
```

## Case语句

### 括号在Case语句中是非必要的，但当一个Case包含多行语句时，要加上括号

```
switch (condition) {
    case 1:
        // ...
        break;
    case 2: {
        // ...
        // Multi-line example using braces
        break;
       }
    case 3:
        // ...
        break;
    default: 
        // ...
        break;
}
```

### 当switch语句里使用可枚举的变量的时候，`default`是不必要的，没有`default`有利于错误的排查

```
switch (menuType) {
    case ZOCEnumNone:
        // ...
        break;
    case ZOCEnumValue1:
        // ...
        break;
    case ZOCEnumValue2:
        // ...
        break;
}
```
### 关于遍历

多用快速遍历（for in）或者block的方式遍历,少用常规for循环

## Enumerated Types枚举类型推荐使用`NS_ENUM()`

### 用枚举表示状态，选项，状态码，可读性和可用性会大大增加


## 命名规则

### 尽量遵守Apple命名约定，推荐使用长的，描述性的方法和变量名

推荐

```
UIButton *settingsButton;
```

不推荐

```
UIButton *setBut; // 方法和变量尽量不要带set get 前缀
```

### Constants常量

#### 多用类型常量，少用`#define`预处理指令，有利于错误检测

常量命名：

常量如果局限于某个实现文件（.m）中时，使用前缀`k`。如果常量在类之外可见，则使用类名作为前缀。常量应该用`static`声明，并且不要使用`#define`,除非他就是明确作为一个宏。

推荐

```
static const NSTimeInterval kFadeOutAnimationDuration = 0.4; // 只在.m 可见

static const NSTimeInterval ZOCSignInViewControllerFadeOutAnimationDuration = 0.4; // 类外可见

static NSString * const ZOCCacheControllerDidClearCacheNotification = @"ZOCCacheControllerDidClearCacheNotification";
```

不推荐

```
static const NSTimeInterval fadeOutTime = 0.4;

 #define CompanyName @"Apple Inc.

```

类型常量如果在类外可见，则应该在.h文件中这样声明`extern NSString *const ZOCCacheControllerDidClearCacheNotification;`，在.m中这样声明`NSString * const ZOCCacheControllerDidClearCacheNotification = @"ZOCCacheControllerDidClearCacheNotification";`

### 方法命名在方法类型（-/+符号）后应该有一个空格，方法段之间也该有一个空格，参数名称之前总应有一个描述性关键词，尽量不使用`and`等连接词来表明多个参数

推荐

```
- (void)setExampleText:(NSString *)text image:(UIImage *)image;
- (void)sendAction:(SEL)aSelector to:(id)anObject forAllCells:(BOOL)flag;
- (id)viewWithTag:(NSInteger)tag;
- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;
```

不推荐

```
- (void)setT:(NSString *)text i:(UIImage *)image;
- (void)sendAction:(SEL)aSelector :(id)anObject :(BOOL)flag;
- (id)taggedView:(NSInteger)tag;
- (instancetype)initWithWidth:(CGFloat)width andHeight:(CGFloat)height;
- (instancetype)initWith:(int)width and:(int)height;  // Never do this.
```

### 字面量/语法糖，多使用字面量来创建不可变的实例对象。

推荐

```
NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"};
NSNumber *shouldUseLiterals = @YES;
NSNumber *buildingZIPCode = @10018;
```

不推荐

```
NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill", @"Mobile Web", nil];
NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];
NSNumber *buildingZIPCode = [NSNumber numberWithInteger:10018];
```


## 美化代码

- 缩进使用4个空格
- 方法的大括号和其他的大括号(if/else/switch/while 等) 总是在同一行开始，在新起一行结束。

	推荐:
	
	```
	if (user.isHappy) {
	    //Do something
	}
	else {
	    //Do something else
	}
	
	```
	
	不推荐:
	
	```
	if (user.isHappy)
	{
	  //Do something
	} else {
	  //Do something else
	}
	```
	
- 方法之间应该要有一个空行来帮助代码看起来清晰且有组织。 方法内的空格应该用来分离功能，但是通常不同的功能应该用新的方法来定义。
- 优先使用 auto-synthesis。但是如果必要的话， @synthesize and @dynamic
- 在实现文件中的声明应该新起一行。
- 应该总是让冒号对齐。有一些方法签名可能超过三个冒号，用冒号对齐可以让代码更具有可读性。即使有代码块存在，也应该用冒号对齐方法。

	推荐：
	
	```
	[UIView animateWithDuration:1.0
                 animations:^{
                     // something
                 }
                 completion:^(BOOL finished) {
                     // something
                 }];
	```
	
- 长行代码可以在第二行以一个间隔（2个空格）延续

	```
	self.productsRequest = [[SKProductsRequest alloc]
   	  initWithProductIdentifiers:productIdentifiers];
	```


## 代码组织

### 利用代码块
	
代码块如果在闭合的圆括号内的话，会返回最后语句的值。

```
NSURL *url = ({
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", baseURLString, endpoint];
    [NSURL URLWithString:urlString];
});
```

### Pragma

#### 使用 `#Pragma Mark`进行代码分组：

- 不通功能组的实现
- protocols的实现
- 对父类方法的重写

```
- (void)dealloc { /* ... */ }
- (instancetype)init { /* ... */ }

#pragma mark - View Lifecycle （View 的生命周期）

- (void)viewDidLoad { /* ... */ }
- (void)viewWillAppear:(BOOL)animated { /* ... */ }
- (void)didReceiveMemoryWarning { /* ... */ }

#pragma mark - Custom Accessors （自定义访问器）

- (void)setCustomProperty:(id)value { /* ... */ }
- (id)customProperty { /* ... */ }

#pragma mark - IBActions  

- (IBAction)submitData:(id)sender { /* ... */ }

#pragma mark - Public

- (void)publicMethod { /* ... */ }

#pragma mark - Private

- (void)zoc_privateMethod { /* ... */ }

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { /* ... */ }

#pragma mark - ZOCSuperclass

// ... 重载来自 ZOCSuperclass 的方法

#pragma mark - NSObject

- (NSString *)description { /* ... */ }

``` 

或者

![image](pic1.png)

### 忽略警告： 

```
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

[myObj performSelector:mySelector withObject:name];

#pragma clang diagnostic pop
```

```
- (NSInteger)giveMeFive
{
    NSString *foo;
    #pragma unused (foo)

    return 5;
}
```

### 明确警告与错误标识

- 手动置为错误`#error Whoa, buddy, you need to check for zero here!`
- 手动警告`#warning Dude, don't compare floating point numbers like this!`

### 注释

- .h 头文件中声明该类的作用
- 接口方法应该有注释
- 如果变量或方法名不明确的应该加上注释


## 接口与API设计

- 类加上前缀，避免命名空间冲突
- 提供designated initializer
- 尽量创建不可变对象，不要把可变对象属性公开，而是提供相关方法。
- 属性如果有读写权限设定，需要用`readonly`声明
- 方法命名要清晰，尽量不使用缩略词
- 私有方法可以加上前缀，如`- (void)p_privateMethod`,但不要用下划线开头;


## 类

### 类的头文件（.h）中尽量少引入其他头文件，避免互相引用，降低耦合，减少编译时间

.h中要引入类时，只需要声明有这个类，具体细节不用暴露，使用向前声明（forward declaring）该类，即：`@class XXXX`。
在.m实现文件中使用该类时需要知道所有接口袭击，即需要import,`#import XXXX`


### 类名，应加上三个大写字母作为前缀（两个字母为Apple类保留，WTF😢），为了减少没有命名空间导致的问题

### Initializer和dealloc初始化，将`dealloc`方法写在实现文件最前面，`init`方法放在`dealloc`之后。

使用ARC的话，dealloc方法中不用调用`super dealloc`,dealloc中只应释放引用，取消KVO的订阅或Notification，不做其他事情。

### Designated和secondary Initializer

designated初始化方法提供所有的参数，一个类应该有且只有一个，secondary初始化方法是一个或多个，并且提供一个或者更多的默认参数来调用Designated初始化方法的初始化方法。

eg:

```
@implementation ZOCEvent
 
 // designated初始化方法，一个类应该有且只有一个
- (instancetype)initWithTitle:(NSString *)title
                         date:(NSDate *)date
                     location:(CLLocation *)location
{
    self = [super init];
    if (self) {
        _title    = title;
        _date     = date;
        _location = location;
    }
    return self;
}
 
 // 一下为secondary初始化方法
- (instancetype)initWithTitle:(NSString *)title
                         date:(NSDate *)date
{
    return [self initWithTitle:title date:date location:nil];
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title date:[NSDate date] location:nil];
}
 
@end
```

在类继承中调用任何 `designated` 初始化方法都是合法的，而且应该保证 所有的 `designated initializer` 在类继承中是是从祖先（通常是  `NSObject`）到你的类向下调用的。 实际上这意味着第一个执行的初始化代码是最远的祖先，然后从顶向下的类继承，所有类都有机会执行他们特定的初始化代码。这样，你在你做你的特定的初始化工作前，所有你从超类继承的东西是不可用的状态。即使它的状态不明确，所有 Apple 的框架的 Framework 是保证遵守这个约定的，而且你的类也应该这样做。

定义一个新类的时候有三个不同方式：

- 不需要重载任何初始化函数
- 重载designated initializer
- 定义一个新的designated initializer

第一个方案是最简单的：你不需要增加类的任何初始化逻辑，只需要依照父类的designated initializer。 当你希望提供额外的初始化逻辑的时候你可以重载 designated initializer。你只需要重载你的直接的超类的 designated initializer 并且确认你的实现调用了超类的方法。

在你希望提供你自己的初始化函数的时候，你应该遵守这三个步骤来保证正确的性：

- 定义你的 designated initializer，确保调用了直接超类的 designated initializer
- 重载直接超类的 designated initializer。调用你的新的 designated initializer.
- 为新的 designated initializer 写文档

通过宏来指定，正确实现例子：

```
@interface ZOCNewsViewController : UIViewController
 
- (instancetype)initWithNews:(ZOCNews *)news ZOC_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil ZOC_UNAVAILABLE_INSTEAD(initWithNews:);
- (instancetype)init ZOC_UNAVAILABLE_INSTEAD(initWithNews:);
 
@end

```

```
@implementation ZOCNewsViewController
 
- (instancetype)initWithNews:(ZOCNews *)news
{
    // call to the immediate superclass's designated initializer
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _news = news;
    }
    return self;
}
 
// Override the immediate superclass's designated initializer （重载直接父类的  designated initializer）
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // call the new designated initializer
    return [self initWithNews:nil];
}
 
@end
```

**注意：**你应该永远不从 designated initializer 里面调用一个 secondary initializer （如果secondary initializer 遵守约定，它会调用 designated initializer）。如果这样，调用很可能会调用一个子类重写的 init 方法并且陷入无限递归之中。

secondary initializer 是一种方便提供默认值、行为到 designated initializer 的 方法。也就是说，你不应该强制很多初始化操作在这样的方法里面，并且你应该一直假设这个方法不会得到调用。我们保证的是唯一被调用的方法是 designated initializer。 这意味着你的 designated initializer 总是应该调用其他的 secondary initializer 或者你 self 的 designated initializer。有时候，因为错误，可能打成了  super，这样会导致不符合上面提及的初始化顺序（在这个特别的例子里面，是跳过当前类的初始化）

#### 一个相关的返回类型可以明确的规定用`instancetype`关键字作为返回类型

#### 初始化模式

**类簇（class cluster）**:一个在共有的抽象超类下设置一组私有子类的架构->**抽象工厂**设计模式，比如`NSNumber`,`NSArray`。

特点：这个模式的精妙的地方在于，调用者可以完全不管子类，事实上，这可以用在设计一个库，可以用来交换实际的返回的类，而不用去管相关的细节，因为它们都遵从抽象超类的方法。

class cluster 的想法很简单，你经常有一个抽象类在初始化期间处理信息，经常作为一个构造器里面的参数或者环境中读取，来完成特定的逻辑并且实例化子类。这个"public facing" 应该知晓它的子类而且返回适合的私有子类。

**单例：**如果可能，请尽量避免使用单例而是**依赖注入**，使用单例请使用线程安全模式来创建共享实例`dispatch_once()`。*注意单例的滥用*

单例模式应该运用于类及类的接口趋向于作为单例来使用的情况 

#### 属性，属性应该尽可能描述性的命名，避免缩写，而且是首字母小写的驼峰命名,应该总是使用`setter`和`getter`方法访问属性，除了`init`和`dealloc`方法。

eg:`NSString *text`,不推荐`NSString* text`或 `NSString * text`

属性getter/setter的好处：

- 使用 setter 会遵守定义的内存管理语义(strong, weak, copy etc...)。举个例子，copy 每个时候你用 setter 并且传送数据的时候，它会复制数据而不用额外的操作
- KVO 通知(willChangeValueForKey, didChangeValueForKey) 会被自动执行
- 更容易debug：你可以设置一个断点在属性声明上并且断点会在每次 getter / setter 方法调用的时候执行，或者你可以在自己的自定义 setter/getter 设置断点。
- 允许在一个单独的地方为设置值添加额外的逻辑。

getter特点:

- 它是对未来的变化有扩展能力的（比如，属性是自动生成的）
- 它允许子类化
- 更简单的debug（比如，允许拿出一个断点在 getter 方法里面，并且看谁访问了特别的 getter
- 它让意图更加清晰和明确：通过访问 ivar _anIvar 你可以明确的访问 self->_anIvar.这可能导致问题
。在 block 里面访问 ivar （你捕捉并且 retain 了 self 即使你没有明确的看到 self 关键词）
- 它自动产生KVO 通知
- 在消息发送的时候增加的开销是微不足道的。

**注意:**永远不能在init以及其他初始化函数里面和dealloc方法中用getter和setter方法，应该直接访问实例变量。
一个子类可以重载getter和setter并且尝试调用其他方法，访问属性他们可能没有完全初始化。

**点符号：**属性有关时尽量使用点符号,区分属性的访问还是方法调用

推荐

```
view.backgroundColor = [UIColor orangeColor];

[UIApplication sharedApplication].delegate;
```

不推荐

```
[view setBackgroundColor:[UIColor orangeColor]];

UIApplication.sharedApplication.delegate;
```
**属性定义:**属性参数按照**原子性**、**读写**和**内存管理**顺序排列,例如`@property (nonatomic, readwrite, copy) NSString *name; `

除非特别情况，原子性请使用`nonatomic`,iOS 中`atomic`带来的锁特别影响性能。

`NSString`,`NSArray`,`NSDictionary`等可变对象和`block`请使用`copy`关键字。block最早在栈中创建，通过Copy拷贝到堆里。可变对象参考*深拷贝与浅拷贝*

对于getter公有，setter私有的公开属性，需要在.h设置为`readonly`，并在类扩展中重新定义通用的属性为`readwrite`。

```
@interface MyClass : NSObject
@property (nonatomic, readonly, strong) NSObject *object
@end
  
@interface MyClass ()
@property (nonatomic, readwrite, strong) NSObject *object
@end
```

**私有属性：**应该在实现文件的类扩展（class extensions，没有名字的categories）中声明。

### 方法

#### 参数断言：最好使用`NSParameterAssert()`来断言条件是否成立或是抛出一个异常。

#### 私有方法：永远不要在私有方法前加上`_`前缀，此前缀被Apple保留。


### 相等性：当我们要自己实现相等性的时候，需要实现`isEqual`和`hash`方法。

如果两个对象是被`isEqual`认为相等的，它们的 `hash` 方法需要返回一样的值。但是如果  `hash` 返回一样的值，并不能确保他们相等。自行百度。

## 分类（Categories）,在方法名加上前缀和下划线

当一个类中逻辑方法很多时，可以将代码按照逻辑划分到不同的分类当中。将私有方法放到`private`分类中是一个好的实践。如果不想暴露实现细节则在class_continuation分类（没有名字的分类）中声明。

**注意：**

- 分类中的方法应该加上自己小写的前缀和下划线。比如`- (void)abc_myCategoryMethod;`，这样可以避免与其他的Category中的方法重名。
- 不要在分类中重载系统方法，可能会导致莫名其妙的问题。
- 最好把所有属性都定义在主接口里。尽量不要在分类中声明属性，虽然可以在分类中添加属性，但是这样会使调试变得困难，推荐使用存取方法。


## 协议（Protocol），实现抽象接口，利于代码复用

在 Objective-C 的世界里面经常错过的一个东西是抽象接口。接口（interface）这个词通常指一个类的 .h 文件，但是它在 Java 程序员眼里有另外的含义：
 一系列不依赖具体实现的方法的定义。

当实现一个 protocol 你总应该坚持[里氏替换原则](https://en.wikipedia.org/wiki/Liskov_substitution_principle)。
这个原则是：你应该可以取代任意接口（也就是Objective-C里的"protocol"）实现，而不用改变客户端或者相关实现。

可以参考[代码](https://github.com/KevinHM/ADBFeedReader)

### 通过协议提供匿名对象

- 协议可以提供匿名类型。具体的对象类型可以淡化成遵从某协议的id类型，协议里规定了对象所应实现的方法。
- 使用匿名对象来隐藏类型名称（或类名）
- 如果具体类型不重要，重要的是对象能够响应（定义在协议里的）特定方法，那么可以使用匿名对象来表示




## 通知（Notification）

当你定义你自己的 NSNotification 的时候你应该把你的通知的名字定义为一个字符串常量，就像你暴露给其他类的其他字符串常量一样。
你应该在公开的接口文件中将其声明为 extern 的， 并且在对应的实现文件里面定义。

```
// Foo.h
extern NSString * const ZOCFooDidBecomeBarNotification

// Foo.m
NSString * const ZOCFooDidBecomeBarNotification = @"ZOCFooDidBecomeBarNotification";
```



## 对象的通讯

### Block

当block作为异步接口的时候，尽量使用一个单独的block作为接口的最后一个参数。把需要提供的数据和错误信息整合到一个单独的block中，比分别提供要好

- 通常这成功处理和失败处理会共享一些代码（比如让一个进度条或者提示消失）；
- Apple 也是这样做的，与平台一致能够带来一些潜在的好处；
- block 通常会有多行代码，如果不作为最后一个参数放在后面的话，会打破调用点；
- 使用多个 block 作为参数可能会让调用看起来显得很笨拙，并且增加了复杂性。
- 若 objects 不为 nil，则 error 必须为 nil
- 若 objects 为 nil，则 error 必须不为 nil

```
- (void)downloadObjectsAtPath:(NSString *)path
                   completion:(void(^)(NSArray *objects, NSError *error))completion {
    if (objects) {
        // do something with the data
    }
    else {
        // some error occurred, 'error' variable should not be nil by contract
    }
}
```
**注意：**Apple 提供的一些同步接口在成功状态下向 error 参数（如果非 NULL) 写入了垃圾值，所以检查 error 的值可能出现问题。

#### 关于block的一点知识

- block 是在栈上创建的
- block 可以复制到堆上
- block会捕获栈上的变量(或指针)，将其复制为自己私有的const(变量)。
- (如果在Block中修改Block块外的)栈上的变量和指针，那么这些变量和指针必须用__block关键字申明(译者注：否则就会跟上面的情况一样只是捕获他们的瞬时值)。

如果 block 没有在其他地方被保持，那么它会随着栈生存并且当栈帧（stack frame）返回的时候消失。
仅存在于栈上时，block对对象访问的内存管理和生命周期没有任何影响。

如果 block 需要在栈帧返回的时候存在，它们需要明确地被复制到堆上，这样，block 会像其他 Cocoa 对象一样增加引用计数。
当它们被复制的时候，它会带着它们的捕获作用域一起，retain 他们所有引用的对象。

如果一个 block引用了一个栈变量或指针，那么这个block初始化的时候会拥有这个**变量或指针的const副本**，
所以(被捕获之后再在栈中改变这个变量或指针的值)是不起作用的。

当一个 block 被复制后，__block 声明的栈变量的引用被复制到了堆里，复制完成之后，
无论是栈上的block还是刚刚产生在堆上的block(栈上block的副本)都会引用该变量在堆上的副本。

```
 ...
 CGFloat blockInt = 10;
 void (^playblock)(void) = ^{
     NSLog(@"blockInt = %zd", blockInt);
 };
 blockInt ++;
 playblock();
 ...

 //结果为:blockInt = 10
```  

#### self的循环引用

当使用代码块和异步分发的时候，要注意避免引用循环。 总是使用 weak 来引用对象，避免引用循环。
此外，把持有 block 的属性设置为 nil (比如 self.completionBlock = nil) 是一个好的实践。它会打破 block 捕获的作用域带来的引用循环。

```
// 多语句是需要在block里强引用一次
__weak __typeof(self)weakSelf = self;
[self executeBlock:^(NSData *data, NSError *error) {
    __strong __typeof(weakSelf) strongSelf = weakSelf;
    if (strongSelf) {
        [strongSelf doSomethingWithData:data];
        [strongSelf doSomethingWithData:data];
    }
}];
```


### 委托和数据源

委托模式 是 Apple 的框架里面使用广泛的模式，同时它是四人帮的书“设计模式”中的重要模式之一。
委托代理模式是单向的，消息的发送方（委托方）需要知道接收方（代理方）是谁，反过来就没有必要了。
对象之间耦合较松，发送方仅需知道它的代理方是否遵守相关 protocol 即可。

本质上，委托代理模式仅需要代理方提供一些回调方法，即代理方需要实现一系列**空返回值**的方法。

然而Apple并没有遵守改原则，比如TableView的Delegate和DataSource

为了分离概念，我们应该这样做：

**委托模式(delegate pattern)**：事件发生的时候，委托者需要通知代理者。
**数据源模式(datasource pattern)**: 委托者需要从数据源对象拉取数据。

```
@class ZOCSignUpViewController;

@protocol ZOCSignUpViewControllerDelegate <NSObject>
- (void)signUpViewControllerDidPressSignUpButton:(ZOCSignUpViewController *)controller;
@end

@protocol ZOCSignUpViewControllerDataSource <NSObject>
- (ZOCUserCredentials *)credentialsForSignUpViewController:(ZOCSignUpViewController *)controller;
@end


@interface ZOCSignUpViewController : UIViewController

@property (nonatomic, weak) id<ZOCSignUpViewControllerDelegate> delegate;
@property (nonatomic, weak) id<ZOCSignUpViewControllerDataSource> dataSource;

@end
```
**代理方法必须以调用者(即委托者)作为第一个参数，就像上面的例子一样。否则代理者无法区分不同的委托者实例。**


#### 继承

有时候你可能需要**重载代理方法**。考虑有两个 UIViewController 子类的情况：UIViewControllerA 和 UIViewControllerB，有下面的类继承关系。

UIViewControllerA 遵从 UITableViewDelegate 并且实现了 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath.

你可能会想要在 UIViewControllerB 中提供一个不同的实现，这个实现可能是这样子的：

```
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat retVal = 0;
    if ([super respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        retVal = [super tableView:self.tableView heightForRowAtIndexPath:indexPath];
    }
    return retVal + 10.0f;
}
```
但如果超类没有实现该方法时，此时调用[super respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]方法，将使用 NSObject 的实现。
根据消息机制，会出现crash。

这时可以换一种实现方式：

```
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   CGFloat retVal = 0;
   if ([[UIViewControllerA class] instancesRespondToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
       retVal = [super tableView:self.tableView heightForRowAtIndexPath:indexPath];
   }
   return retVal + 10.0f;
}
```

#### 多重委托

多重委托是一个非常基础的概念，但是，大多数开发者对此非常不熟悉而使用 NSNotifications。多重委托实现方式有多重,可参考[LBDelegateMatrioska](https://github.com/lukabernardi/LBDelegateMatrioska)，可自行百度。

## 使用`NSCache`来构建缓存，而非`NSDictionary`

`NSCache`提供优雅的自动删减功能，而且线程安全，不会像Dictionary一样拷贝Key.`NSCache`可与`NSPurgeableData`搭配使用，实现数据的自动清除功能。

## Aspect Oriented Programming (AOP，面向切面编程)

Aspect Oriented Programming (AOP，面向切面编程) 在 Objective-C 社区内没有那么有名，但是 AOP 在运行时可以有巨大威力。 但是因为没有事实上的标准，Apple 也没有开箱即用的提供，也显得不重要，开发者都不怎么考虑它。

通常 AOP 被用来实现横向切面。统计与日志就是一个完美的例子。

我们使用运行时的特性来增加切面：

- 在类的特定方法调用前运行特定的代码
- 在类的特定方法调用后运行特定的代码
- 增加代码来替代原来的类的方法的实现

可参考[Aspects](https://github.com/steipete/Aspects)




-----
