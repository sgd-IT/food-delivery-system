// 测试订单类型功能
function testOrderType() {
  console.log('测试订单类型功能开始');
  
  // 模拟初始化
  const mockVm = {
    data: {},
    setData: function(data) {
      this.data = Object.assign({}, this.data, data);
      console.log('setData:', this.data);
    }
  };
  
  // 测试初始化逻辑
  if (mockVm.data.orderType === undefined) {
    mockVm.setData({
      orderType: 2  // 默认外卖配送
    });
  }
  console.log('初始化后orderType:', mockVm.data.orderType);
  
  // 测试切换到店自取
  const mockEvent1 = {
    currentTarget: {
      dataset: {
        type: '1'
      }
    }
  };
  
  function changeOrderType(e) {
    const type = parseInt(e.currentTarget.dataset.type);
    mockVm.setData({
      orderType: type
    });
  }
  
  changeOrderType(mockEvent1);
  console.log('切换到店自取后orderType:', mockVm.data.orderType);
  
  // 测试切换外卖配送
  const mockEvent2 = {
    currentTarget: {
      dataset: {
        type: '2'
      }
    }
  };
  
  changeOrderType(mockEvent2);
  console.log('切换外卖配送后orderType:', mockVm.data.orderType);
  
  // 测试参数传递
  const params = {};
  if (typeof params !== 'undefined') {
    params.orderType = mockVm.data.orderType || 2;
  }
  console.log('传递给后端的参数:', params);
  
  console.log('测试订单类型功能结束');
}

// 运行测试
testOrderType();