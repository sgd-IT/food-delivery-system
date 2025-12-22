/**
 * 固定地址配置
 * 这些地址会显示在所有用户的地址列表中，供用户选择
 */
const fixedAddresses = [
  {
    id: 'fixed_001',
    consignee: '木东',
    phone: '13800138001',
    sex: '0',
    label: '3', // 1-公司, 2-家, 3-学校
    provinceCode: '44',
    provinceName: '广东省',
    cityCode: '4419',
    cityName: '东莞市',
    districtCode: '441900',
    districtName: '石排镇',
    detail: '广东科技学院A1宿舍楼',
    isDefault: 0,
    isFixed: true
  },
  {
    id: 'fixed_002',
    consignee: '木东',
    phone: '13800138002',
    sex: '0',
    label: '3',
    provinceCode: '44',
    provinceName: '广东省',
    cityCode: '4419',
    cityName: '东莞市',
    districtCode: '441900',
    districtName: '石排镇',
    detail: '广东科技学院A2宿舍楼',
    isDefault: 0,
    isFixed: true
  },
  {
    id: 'fixed_003',
    consignee: '木东',
    phone: '13800138003',
    sex: '0',
    label: '3',
    provinceCode: '44',
    provinceName: '广东省',
    cityCode: '4419',
    cityName: '东莞市',
    districtCode: '441900',
    districtName: '石排镇',
    detail: '广东科技学院A3宿舍楼',
    isDefault: 0,
    isFixed: true
  }
]

module.exports = {
  fixedAddresses: fixedAddresses
}

