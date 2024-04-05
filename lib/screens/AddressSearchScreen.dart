import 'package:flutter/material.dart';
import 'package:testapp/controllers/ApiController.dart';
import 'package:testapp/screens/DongSelectionScreen.dart';
import 'package:testapp/screens/FloorSelectionScreen.dart';

class AddressSearchScreen extends StatefulWidget {
  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  ApiController _apiController = ApiController();
  List<dynamic> _addressList = [];
  String _selectedAddress = '';
  Map<String, Map<String, List<String>>>? _detailAddressData;

  void _onSearch() async {
    final addresses = await _apiController.fetchDataFromApi(_searchController.text);
    setState(() {
      _addressList = addresses;
    });
  }

  void _fetchAndDisplayDetailAddress(String admCd, String rnMgtSn, String udrtYn, String searchType, String dongNm, String buldMnnm, String buldSlno) async {
    var detailAddressData = await _apiController.fetchDetailAddress(admCd, rnMgtSn, udrtYn, searchType, dongNm, buldMnnm, buldSlno);
    setState(() {
      _detailAddressData = detailAddressData.cast<String, Map<String, List<String>>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소 검색'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Address',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _addressList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_addressList[index]['roadAddr']),
                    onTap: () async {
                      // Fetch the detailed address data
                      var detailAddressData = await _apiController.fetchDetailAddress(
                        _addressList[index]['admCd'],
                        _addressList[index]['rnMgtSn'],
                        _addressList[index]['udrtYn'],
                        _addressList[index]['searchType'],
                        _addressList[index]['dongNm'],
                        _addressList[index]['buldMnnm'],
                        _addressList[index]['buldSlno'],
                      );

                      // Check the number of dongs
                      List<String> dongs = detailAddressData.keys.toList();
                      if (dongs.length <= 1) {
                        // If there's one or no dong, go directly to the FloorSelectionScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FloorSelectionScreen(
                              apiController: _apiController,
                              addressData: _addressList[index],
                              selectedDong: dongs.isNotEmpty ? dongs.first : '없음',
                            ),
                          ),
                        );
                      } else {
                        // If there are multiple dongs, go to the DongSelectionScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DongSelectionScreen(
                              addressData: _addressList[index],
                              apiController: _apiController,
                            ),
                          ),
                        );
                      }
                    },

                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}