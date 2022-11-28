import 'package:betdelalamobile/providers/house_file.dart';
import 'package:flutter/cupertino.dart';


class Houses with ChangeNotifier {
  final List<HouseFile> _items = [
    HouseFile(
        id: 'm1',
        title: 'hOUSE RENT',
        price: '12,500,500 ETB',
        imageUrl:
            'https://th.bing.com/th/id/R.fb241759639800311cb682559ceb2e17?rik=LmQG4lMsdKBOtw&riu=http%3a%2f%2f1.bp.blogspot.com%2f-RuznhkD1s88%2fUm6a-W_LD9I%2fAAAAAAAA1G0%2fB9tc_wv5Gr8%2fs1600%2fhouse-for-rent.jpg&ehk=pLpqxYx72nHtaFXg7vwj5GQkkMvXhNzL2%2bmamPbH7nA%3d&risl=&pid=ImgRaw&r=0',
        location: 'BahirDar,Ethiopia',
        rentInformation: 'pending',
        specification: [
          
            'Built in:2011',
            'Type: house',
            'size: 2,338 square meter',
            'Bath: 2',
            'Garage :2 cars',
            'feature :solar panal,hot tub,high cealing,sunroof'
          
        ],
        description: [
          'Very good house with the minimal price and  values as expected from the start,This is one of the house which is best and efficent you have to take it and use it as your expectations '
        ],
        information: 
          '4bds,2ba,2338 sq m'
        
        ),
    HouseFile(
        id: 'm2',
        title: 'priceless House',
        price: '1,500,500 ETB',
        imageUrl:
            'https://th.bing.com/th/id/R.8e240b34f5efc2a7e0b483e65876bfd1?rik=vzM00q%2flMlv89w&riu=http%3a%2f%2fcrm.agentlocator.ca%2fimagegallery%2f2014-8%2fHouse2.jpg&ehk=gj3CwHTlThh5tueE2W4xPZnhb1ptKMQrynKBggZWfcc%3d&risl=&pid=ImgRaw&r=0',
        location: 'Addis Abeba,Ethiopia',
        rentInformation: 'pending',
         specification: [
          
            'Built in:2011',
            'Type: house',
            'size: 2,338 square meter',
            'Bath: 2',
            'Garage :2 cars',
            'feature :solar panal,hot tub,high cealing,sunroof'
          
        ],
        description: [
         'Very good house with the minimal price and  values as expected from the start,This is one of the house which is best and efficent you have to take it and use it as your expectations '
         
        ],
        information: 
          '4bds,2ba,2338 sqm'
        
        ),
    HouseFile(
        id: 'm3',
        title: 'very Good House for Sale',
        price: '1,500,500 ETB',
        imageUrl:
            'https://th.bing.com/th/id/OIP.pioMkv3xEY2rQuffZK6UQgAAAA?pid=ImgDet&rs=1',
        location: 'Hawasa,Ethiopia',
        rentInformation: 'pending',
         specification: [
          
            'Built in:2011',
            'Type: house',
            'size: 2,338 square meter',
            'Bath: 2',
            'Garage :2 cars',
            'feature :solar panal,hot tub,high cealing,sunroof'
          
        ],
        description: [
        'Very good house with the minimal price and  values as expected from the start,This is one of the house which is best and efficent you have to take it and use it as your expectations '
        ],
        information: 
          '4bds,2ba,2338 sq m'
        )
  ];
  List<HouseFile> get items {
    return [..._items];
  }

  HouseFile findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
