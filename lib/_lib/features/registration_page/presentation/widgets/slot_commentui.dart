import 'package:flutter/material.dart';
import 'package:gymproject/_lib/features/registration_page/data/dto/slotcomment.dart';
import 'package:gymproject/_lib/features/registration_page/data/services/slotcomment_service.dart';

class SlotCommentsPanel extends StatefulWidget {
  final DateTime date;
  final String timeRange;

  const SlotCommentsPanel({
    super.key,
    required this.date,
    required this.timeRange,
  });

  @override
  State<SlotCommentsPanel> createState() => _SlotCommentsPanelState();
}

class _SlotCommentsPanelState extends State<SlotCommentsPanel> {
  final _controller = TextEditingController();
  final service = SlotCommentService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          const Text(
            "Comments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 300,
            child: StreamBuilder<List<SlotComment>>(
              stream: service.getComments(
                date: widget.date,
                timeRange: widget.timeRange,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final comments = snapshot.data!;

                if (comments.isEmpty) {
                  return const Center(child: Text("No comments yet"));
                }

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (_, i) {
                    final c = comments[i];

                    return ListTile(
                      title: Text(
                        c.userName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(c.text),
                      trailing: Text(
                        "${c.createdAt.hour}:${c.createdAt.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const Divider(),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Write a comment...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  final text = _controller.text.trim();
                  if (text.isEmpty) return;

                  await service.addComment(
                    date: widget.date,
                    timeRange: widget.timeRange,
                    text: text,
                  );

                  _controller.clear();
                },
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
