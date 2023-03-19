import 'package:flutter/material.dart';

import '../../models/poll.dart';
import '../../services/api.dart';
import '../my_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Poll>? _polls;
  var _isLoading = false;
  var _isError = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    try {
      var result = await ApiClient().getPoll();

      setState(() {
        _polls = result;
      });
    } catch (e) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Image.network(
              'https://cpsu-test-api.herokuapp.com/images/election.jpg'),
          Expanded(
            child: Stack(
              children: [
                if (_polls != null) _buildList(),
                if (_isLoading) _buildProgress(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: _polls!.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_polls![index].question),

              ],
            ),
            Row(
              children: [
                Container(
                  height: 500,width: 500,
                  padding: EdgeInsetsDirectional.all(20),
                  child: ElevatedButton(onPressed: (){}, child: Text("asdad")),
                 
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildProgress() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.white),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('รอสักครู่', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
