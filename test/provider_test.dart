
import 'package:flutter_test/flutter_test.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/models/item_model.dart';

void main() {
  group(
    'test_item',() {
    test("asdasd", () {
      var yourList = [
        ItemModel.fromOther(1, "second", null, DateTime(2021, 1, 2))];

      expect(yourList, [
        ItemModel.fromOther(1, "second", null, DateTime(2021, 1, 2))]);
    });
  });



  group('Sort', () {
    test('Sort by dates', () {
      // Arrange
      var yourList = [
        ItemModel.fromOther(1,"second", null,DateTime(2021, 1, 2)),
        ItemModel.fromOther(0,"third",  DateTime(2021, 1, 4),DateTime(2021, 1, 1)),
        ItemModel.fromOther(2,"first",  null,DateTime(2021, 1, 3)),
      ];


      // Act
      yourList.sort((a,b){
        if(a.updateTime!=null && b.updateTime!=null){
          if(a.updateTime!.isBefore(b.updateTime!)){
            return 1;
          }else{
            return -1;
          }
        }else{
          if(a.updateTime!=null && b.updateTime!=null){
            if(b.creationTime.isBefore(a.creationTime)){
              return -1;
            }else{
              return 1;
            }
          }else{
            if(a.updateTime!=null && b.updateTime==null){
              return -1;
            }else{
              return 1;
            }
          }
        }
      }); // Call your sort function

      // Assert
      expect(yourList, [
        ItemModel.fromOther(0,"third",  DateTime(2021, 1, 4),DateTime(2021, 1, 1)),
        ItemModel.fromOther(2,"first",  null,DateTime(2021, 1, 3)),
        ItemModel.fromOther(1,"second", null,DateTime(2021, 1, 2)),
      ]);
    });
  });
}