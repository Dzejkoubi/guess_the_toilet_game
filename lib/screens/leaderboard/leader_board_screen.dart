import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/services/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  late Future<List<Map<String, dynamic>>> _data;
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _data = getData();
  }

  Future<List<Map<String, dynamic>>> getData() async {
    try {
      // Check if we're authenticated
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        // For anonymous access, use a public function if you have one
        // This depends on your Supabase setup
        final response = await Supabase.instance.client
            .rpc(
                'get_leaderboard') // Assuming you have a function named 'get_leaderboard'
            .limit(10);
        return List<Map<String, dynamic>>.from(response);
      } else {
        // Authenticated access
        final response = await Supabase.instance.client
            .from('profiles')
            .select('username, current_level')
            .order('current_level',
                ascending: false) // Higher levels at the top
            .limit(10);
        return List<Map<String, dynamic>>.from(response);
      }
    } catch (e) {
      // Log the error for debugging
      debugPrint('Leaderboard error: $e');

      // Return empty list but don't crash
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _data = getData();
                      });
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final user = data[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(user['username'] ?? 'Unknown'),
                  subtitle: Text('Level: ${user['current_level'] ?? 0}'),
                );
              },
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No leaderboard data available'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _data = getData();
                    });
                  },
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
