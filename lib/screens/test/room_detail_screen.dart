import 'package:flutter/material.dart';

class RoomDetailScreen extends StatefulWidget {
 @override
 _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
 int _currentImageIndex = 0;
 bool _isFullScreen = false;

 List<String> _images = [
   'assets/images/room1.jpg',
   'assets/images/room2.jpg',
 ];

 void _showFullScreenImage(int index) {
   setState(() {
     _isFullScreen = true;
     _currentImageIndex = index;
   });
 }

 void _exitFullScreen() {
   setState(() {
     _isFullScreen = false;
   });
 }

 void _onImageSwipe(DragUpdateDetails details) {
   if (details.primaryDelta! > 0) {
     // Swiping from left to right
     setState(() {
       _currentImageIndex = (_currentImageIndex - 1) % _images.length;
       if (_currentImageIndex < 0) {
         _currentImageIndex = _images.length - 1;
       }
     });
   } else if (details.primaryDelta! < 0) {
     // Swiping from right to left
     setState(() {
       _currentImageIndex = (_currentImageIndex + 1) % _images.length;
     });
   }
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     extendBodyBehindAppBar: true,
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       foregroundColor: Colors.white60,
       elevation: 0,
     ),
     body: _isFullScreen
         ? GestureDetector(
             onTap: _exitFullScreen,
             onHorizontalDragUpdate: _onImageSwipe,
             child: Stack(
               children: [
                 Center(
                   child: Image.asset(
                     _images[_currentImageIndex],
                     fit: BoxFit.contain,
                   ),
                 ),
                 Positioned(
                   top: 50,
                   right: 16,
                   child: IconButton(
                     icon: Icon(Icons.close, color: Colors.white, size: 32),
                     onPressed: _exitFullScreen,
                   ),
                 ),
                 Positioned(
                   bottom: 16,
                   left: 16,
                   child: Container(
                     padding:
                         EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                     decoration: BoxDecoration(
                       color: Colors.black.withOpacity(0.5),
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: Text(
                       '${_currentImageIndex + 1} / ${_images.length}',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 14,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           )
         : Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               AspectRatio(
                 aspectRatio: 16 / 13,
                 child: Stack(
                   children: [
                     PageView.builder(
                       itemCount: _images.length,
                       onPageChanged: (index) {
                         setState(() {
                           _currentImageIndex = index;
                         });
                       },
                       itemBuilder: (context, index) {
                         return GestureDetector(
                           onTap: () => _showFullScreenImage(index),
                           child: Image.asset(
                             _images[index],
                             fit: BoxFit.cover,
                           ),
                         );
                       },
                     ),
                     Positioned(
                       right: 16,
                       bottom: 16,
                       child: Container(
                         padding:
                             EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                         decoration: BoxDecoration(
                           color: Colors.black.withOpacity(0.5),
                           borderRadius: BorderRadius.circular(12),
                         ),
                         child: Text(
                           '${_currentImageIndex + 1} / ${_images.length}',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 14,
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Padding(
                 padding: EdgeInsets.all(16),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       '서울특별시 강서구 염창동',
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.grey[600],
                       ),
                     ),
                     SizedBox(height: 8),
                     Text(
                       '전세 2억 7,000',
                       style: TextStyle(
                         fontSize: 24,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     SizedBox(height: 16),
                     Row(
                       children: [
                         Icon(Icons.straighten, color: Colors.grey[600]),
                         SizedBox(width: 4),
                         Text(
                           '계약 39.11㎡ / 전용 27.27㎡',
                           style: TextStyle(
                             fontSize: 14,
                             color: Colors.grey[600],
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 8),
                     Row(
                       children: [
                         Icon(Icons.house, color: Colors.grey[600]),
                         SizedBox(width: 4),
                         Text(
                           '투룸 (욕실 1개)',
                           style: TextStyle(
                             fontSize: 14,
                             color: Colors.grey[600],
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 8),
                     Row(
                       children: [
                         Icon(Icons.local_parking, color: Colors.grey[600]),
                         SizedBox(width: 4),
                         Text(
                           '주차 가능',
                           style: TextStyle(
                             fontSize: 14,
                             color: Colors.grey[600],
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 8),
                     Row(
                       children: [
                         Icon(Icons.event_available, color: Colors.grey[600]),
                         SizedBox(width: 4),
                         Text(
                           '입주 10초/12초',
                           style: TextStyle(
                             fontSize: 14,
                             color: Colors.grey[600],
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 16),
                     ElevatedButton(
                       onPressed: () {
                         // 문의하기 버튼 클릭 시 동작
                       },
                       child: Text('문의하기'),
                       style: ElevatedButton.styleFrom(
                         minimumSize: Size(double.infinity, 48),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
   );
 }
}