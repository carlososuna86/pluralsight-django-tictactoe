from django.contrib.auth.decorators import login_required
from django.core.exceptions import PermissionDenied
from django.shortcuts import render, redirect, get_object_or_404
from django.views.generic import ListView

from .models import Game
from .forms import MoveForm

@login_required
def game_detail(request, id):
  game = get_object_or_404(Game, pk=id)
  context = { 'game': game }
  if game.is_user_move(request.user):
    context['form'] = MoveForm()
  return render(
      request,
      "gameplay/game_detail.html",
      context,
  )

@login_required
def make_move(request, id):
  game = get_object_or_404(Game, pk=id)
  if not game.is_user_move(request.user):
    raise PermissionDenied
  move = game.new_move()
  form = MoveForm(instance=move, data=request.POST)
  if form.is_valid():
    move.save()
    return redirect(game)
  else:
    return render(
      request,
      "gameplay/game_detail.html",
      { 'game': game, 'form': form }
    )

class AllGamesList(ListView):
  model = Game
