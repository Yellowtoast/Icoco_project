class EventStatus {
  static const String running = 'running';
  static const String completed = 'completed';
  static const String announnced = 'announced';
}

const emptyProfileUrl =
    'https://firebasestorage.googleapis.com/v0/b/icoco2021.appspot.com/o/manager%2FprofileImage%2Fempty_profile.png?alt=media&token=ac6d9c4c-cfee-4627-ac79-1f62b6f45b8f';

Map<String, String> specialtyItems = {
  '정리정돈': "청소를 깔끔하게 잘 하세요",
  '가족배려': "가족들 모두를 만족시켜주세요",
  '체형관리': "체형교정에 많은 도움을 주세요",
  '음식솜씨': "멋진 식사로 입맛이 살아나요",
  '실전지식': "육아 정보를 많이 알려주세요",
  '산모케어': "산모가 신경쓸 일이 없어요",
  '신생아케어': "아이를 사랑으로 대해주세요",
};

Map<String, String> specialtyItemsIcon = {
  '정리정돈': "icons/cleaning_icon.svg",
  '가족배려': "icons/mother_caring_icon.svg",
  '체형관리': "icons/mother_caring_icon.svg",
  '음식솜씨': "icons/cooking_icon.svg",
  '실전지식': "icons/cleaning_icon.svg",
  '산모케어': "icons/mother_caring_icon.svg",
  '신생아케어': "icons/baby_caring_icon.svg",
};
