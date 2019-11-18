import 'dart:math';
import 'globals.dart' as globals;

class Cell{
  int x;
  int y;
  Cell(int x, int y){
    this.x = x;
    this.y = y;
  }
}


class GFG{
 final N = 8;
 final List<int> cx = [1,1,2,2,-1,-1,-2,-2];
 final List<int> cy = [2,-2,1,-1,2,-2,1,-1];


 bool limits(int x, int y)
 {
   return ((x >= 0 && y >= 0) &&
       (x < N && y < N));
 }

 /* Checks whether a square is valid and
    empty or not */
 bool isempty(List<int> a, int x, int y)
 {
 return (limits(x, y)) && (a[y * N + x] < 0);
 }

 /* Returns the number of empty squares
    adjacent to (x, y) */
 int getDegree(List<int> a, int x, int y)
 {
 int count = 0;
 for (int i = 0; i < N; ++i)
 if (isempty(a, (x + cx[i]),
 (y + cy[i])))
 count++;

 return count;
 }


 Cell nextMove(List<int> a,Cell cell){
   int min_deg_idx = -1, c,
       min_deg = (N + 1), nx, ny;

   // Try all N adjacent of (*x, *y) starting
   // from a random adjacent. Find the adjacent
   // with minimum degree.

  int start = Random.secure().nextInt(1000) % N;
  for (var count = 0; count < N; ++count)
  {
    int i = (start + count) % N;
    nx = cell.x + cx[i];
    ny = cell.y + cy[i];
    if ((isempty(a, nx, ny)) &&
        (c = getDegree(a, nx, ny)) < min_deg)
    {
      min_deg_idx = i;
      min_deg = c;
    }
  }

   // IF we could not find a next cell
   if (min_deg_idx == -1)
     return null;

   // Store coordinates of next point
   nx = cell.x + cx[min_deg_idx];
   ny = cell.y + cy[min_deg_idx];

   // Mark next move
   a[ny * N + nx] = a[(cell.y) * N +
       (cell.x)] + 1;

   // Update next point
   cell.x = nx;
   cell.y = ny;

   return cell;
 }

 void printing(List<int> a)
 {
 for (int i = 0; i < N; ++i)
 {
 for (int j = 0; j < N; ++j) {
   var k = a[j * N + i];
   print('$k \t');
 }
 print("\n");
 }
 }



 /* checks its neighbouring sqaures */
 /* If the knight ends on a square that is one
    knight's move from the beginning square,
    then tour is closed */
 bool neighbour(int x, int y, int xx, int yy)
 {
   for (int i = 0; i < N; ++i)
     if (((x + cx[i]) == xx) &&
         ((y + cy[i]) == yy))
       return true;

   return false;
 }
 bool findClosedTour(int sx,int sy){
   // Filling up the chessboard matrix with -1's

   List<int> a = List(N*N);
   for (int i = 0; i < N * N; ++i)
     a[i] = -1;


   // Current points are same as initial points
   Cell cell = new Cell(sx, sy);

   a[cell.y * N + cell.x] = 1; // Mark first move.

   // Keep picking next points using
   // Warnsdorff's heuristic
   Cell ret = null;
   for (int i = 0; i < N * N - 1; ++i)
   {
     ret = nextMove(a, cell);
     if (ret == null)
       return false;
   }
   // Check if tour is closed (Can end
   // at starting point)
   if (!neighbour(ret.x, ret.y, sx, sy))
     return false;

   globals.value = a;
   return true;
 }
}








