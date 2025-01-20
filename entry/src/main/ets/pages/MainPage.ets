import {
  BreakpointConstants,
  BreakpointSystem,
  Commodity,
  LocalDataManager,
  Logger,
  OrderOperationStatus,
  Product,
  StyleConstants
} from '@ohos/common';
import { OrderCount } from '@ohos/commoditydetail/src/main/ets/viewmodel/TypeModel';
import router from '@ohos.router';
import { PageConstants } from '../constants/PageConstants';
import { buttonInfo, ButtonInfoModel } from '../viewmodel/MainPageData';
import { Home } from '@ohos/home';

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
  private breakpointSystem = new BreakpointSystem()
  private localDataManager: LocalDataManager = LocalDataManager.instance()

  aboutToAppear() {
    this.breakpointSystem.register();
    this.shoppingCartList = this.shoppingCartList?.length > 0 ? this.shoppingCartList : []
    this.queryOrderList()
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister()
  }

  queryShopCart() {
    const shoppingData = this.localDataManager.queryShopCart()
    this.shoppingCartList = shoppingData
    this.shoppingCartCache = shoppingData
  }

  queryOrderList() {
    const orderList = this.localDataManager.queryOrderList()
    this.orderCount = {
      payment: orderList.filter(item => item.status === OrderOperationStatus.UN_PAY).length,
      ship: 0,
      receipt: orderList.filter(item => item.status === OrderOperationStatus.DELIVERED).length,
      evaluation: orderList.filter(item => item.status === OrderOperationStatus.RECEIPT).length,
      sale: 0
    }
  }

  routerDetailPage(data: Commodity) {
    router.pushUrl({
      url: PageConstants.COMMODITY_DETAIL_PAGE_URL,
      params: { id: data.id }
    }).catch((error: Error) => {
      Logger.error(JSON.stringify(error));
    })
  }

  onPageShow() {
    this.queryShopCart();
    this.queryOrderList();
  }

  build() {
    Column() {
      Tabs({
        barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start : BarPosition.End,
        index: this.currentPageIndex,
      }) {
        TabContent() {
          Home()
        }.tabBar(this.BottomNavigation(buttonInfo[PageConstants.HOME_INDEX]))

        TabContent() {
          Home()

        }.tabBar(this.BottomNavigation(buttonInfo[PageConstants.NEW_PRODUCT_INDEX]))

        TabContent() {
          Home()

        }.tabBar(this.BottomNavigation(buttonInfo[PageConstants.SHOP_CART_INDEX]))

        TabContent() {
          Home()

        }.tabBar(this.BottomNavigation(buttonInfo[PageConstants.PERSONAL_INDEX]))
      }
      .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.float.bar_width') : StyleConstants.FULL_WIDTH)
      .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      StyleConstants.SIXTY_HEIGHT : $r('app.float.vp_fifty_six'))
      .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .scrollable(false)
      .onChange((index: number) => {
        this.currentPageIndex = index;
        if (index === PageConstants.PERSONAL_INDEX) {
          this.queryShopCart();
        } else if (index === PageConstants.PERSONAL_INDEX) {
          this.queryOrderList();
        }
      })

      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .backgroundColor($r('app.color.page_background'))
  }

  @Builder
  BottomNavigation(button: ButtonInfoModel) {
    Column({ space: PageConstants.BUTTON_SPACE }) {
      Image(this.currentPageIndex == button.index ? button.selectImg : button.img)
        .objectFit(ImageFit.Contain)
        .width($r('app.float.main_image_size'))
        .height($r('app.float.main_image_size'))

      Text(button.title)
        .fontColor(this.currentPageIndex === button.index ? $r('app.color.focus_color') : Color.Black)
        .opacity(this.currentPageIndex === button.index ? StyleConstants.FULL_OPACITY : StyleConstants.SIXTY_OPACITY)
        .fontWeight(StyleConstants.FONT_WEIGHT_FIVE)
        .textAlign(TextAlign.Center)
        .fontSize($r('app.float.micro_font_size'))
    }.width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}