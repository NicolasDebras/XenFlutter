import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/design/Post/postUx.dart';
import 'package:xenflutter/models/comment.dart';
import 'package:xenflutter/models/post.dart';
import 'package:xenflutter/models/user.dart';
import 'package:xenflutter/services/provider/PostsProvider.dart';

void main() {
  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: Provider<PostsProvider>(
          create: (_) => PostsProvider(),
          child: child,
        ),
      ),
    );
  }

  testWidgets('Post card expands to show comments on tap', (WidgetTester tester) async {
    // Créer un post de test avec des commentaires
    final Post testPost = Post(
      id: 1,
      content: "Test post",
      comments: [
        Comment(id: 1, content: "Test comment 1", author: User(id: 1, name: "User 1", email:'toto', createdAt: '11111'), createdAt: '11111'),
        Comment(id: 2, content: "Test comment 2", author: User(id: 2, name: "User 2", email:'toto', createdAt: '11111'), createdAt: '11111'),
      ],
      commentsCount: 2,
    );

    // Construire l'UI de test
    await tester.pumpWidget(makeTestableWidget(child: PostUx(testPost)));

    // Vérifier si la card est initialement dans son état réduit
    expect(find.byType(Expanded), findsNothing);

    // Simuler un tap sur la card pour l'agrandir
    await tester.tap(find.byType(Card));
    await tester.pumpAndSettle(); // Attendre les animations si nécessaire

    // Vérifier si la card s'est agrandie pour montrer les commentaires
    expect(find.text('Test comment 1'), findsOneWidget);
    expect(find.text('Test comment 2'), findsOneWidget);
  });
}
