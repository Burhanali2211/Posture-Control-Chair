import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../database/app_database.dart';
import '../../widgets/empty_state_view.dart';
import 'providers/history_providers.dart';
import 'widgets/session_detail_sheet.dart';
import 'widgets/session_list_tile.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(allSessionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.navHistory)),
      body: sessionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const EmptyStateView(
          icon:    Icons.error_outline_rounded,
          message: 'Could not load sessions',
        ),
        data: (sessions) => sessions.isEmpty
            ? const _EmptyState()
            : _SessionList(sessions: sessions),
      ),
    );
  }
}

class _SessionList extends StatelessWidget {
  const _SessionList({required this.sessions});

  final List<Session> sessions;

  void _openDetail(BuildContext context, Session session) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SessionDetailSheet(session: session),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: sessions.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: 20,
        endIndent: 20,
        color: AppColors.border,
      ),
      itemBuilder: (context, i) => SessionListTile(
        session: sessions[i],
        onTap: () => _openDetail(context, sessions[i]),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const EmptyStateView(
      icon:     Icons.history_rounded,
      message:  AppStrings.noSessions,
      subtitle: 'Connect the chair and start a session to record data',
    );
  }
}
