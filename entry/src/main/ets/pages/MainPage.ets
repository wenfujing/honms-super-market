import { Product } from '@ohos/common';
import { OrderCount } from '@ohos/commoditydetail/src/main/ets/viewmodel/TypeModel';

@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World'
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  @StorageLink('IndexPage') currentPageIndex: number = 0;
  @State shoppingCartCache: Product[] = [];
  @State shoppingCartList: Product[] = [];
  @State orderCount: OrderCount = {
    payment: 0,
    ship: 0,
    receipt: 0,
    evaluation: 0,
    sale: 0
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}