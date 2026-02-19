
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
		const NewsPage({super.key});
		@override
		State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('NewsPage'),
			),
			body: Column(
				children: [
					Container(),
				],
			),
		);
	}
}
        