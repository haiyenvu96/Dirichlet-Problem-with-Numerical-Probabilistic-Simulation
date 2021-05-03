// definition de la fonction g
function value = g1(x,y)
    value = max(x,y)
endfunction
function value = g2(x,y)
    value = sin(%pi*(x+y))
endfunction
function value = g3(x,y)
    value = x^3-3*x*y^2
endfunction


// parameters
M = 1000
h  = 0.1
// maillage
x = -1 : 0.1 : 1
y = -1 : 0.1 : 1
// taille de maillage
Nx = size(x,2)
Ny = size(y,2)
// store u et le rayon de l'intervalle de confiance
u = zeros(Nx, Ny)
err = zeros(Nx, Ny)
// u de X, Y precedents
//u2 = zeros(Nx, Ny)
//err2 = zeros(Nx, Ny)
// u du choix X,Y probabiliste
//u3 = zeros(Nr, Nta)
//err3 = zeros(Nr, Nta)
// store le nombre de pas
tm = zeros(Nx, Ny)

//boucles sur les points de depart
timer()
for i = 1 : Nx do
  for j = 1 : Ny do
    // initiate les resultats
    tab = zeros(M,1)
    //tab2 = zeros(M,1)
    //tab3 = zeros(M,1)
    time = zeros(M,1)
    // simulation des trajectoires
    for mc = 1 : M do
        // point de depart
      X = x(i)
      Y = y(j)
      // le point predesseur
      //X_pred = X
      //Y_pred = Y
      // while le point est dans D
      while max(abs(X),abs(Y)) < 1 do
        //X_pred = X
        //Y_pred = Y
        // simuler Z
        Z = grand(2,1,'nor',0,1)
        X = X + sqrt(h)*Z(1)
        Y = Y + sqrt(h)*Z(2)
        time(mc) = time(mc) + 1
      end
      //choix probabiliste
      //d = min(X_pred -1, X_pred +1, Y_pred -1, Y_pred +1 )
      //[P,p]=cdfchi("PQ",d^2/h,2)
      //U = grand(1,1,'def')
      //if U > p then
      //    tab3(mc) = g2(X,Y)
      //else
      //    tab3(mc) = g2(X_pred, Y_pred)
      //end
      tab(mc) = g2(X,Y)
//      tab2(mc) = g1(X_pred, Y_pred)
    end
// calculer le moyen et le rayon de l'intervalle de confiance
  u(i,j) = mean(tab)
  err(i,j) = stdev(tab)
//  u2(i,j) = mean(tab2)
//  err2(i,j) = stdev(tab2)
//  u3(i,j) = mean(tab3)
//  err3(i,j) = stdev(tab3)
  tm(i,j) = mean(time)
  end
end
time = timer()
err = 1.96*err/sqrt(M)
//err2 = 1.96*err2/sqrt(M)
//err3 = 1.96*err3/sqrt(M)

// plot les resultats
[yy,xx] = meshgrid(y,x)
scf(0); clf; surf(xx,yy,u); 
scf(1); clf; surf(xx,yy,err);
scf(2); clf; surf(xx,yy,tm);
//scf(3); clf; surf(xx,yy,u2); 
//scf(4); clf; surf(xx,yy,err2);
//scf(5); clf; surf(xx,yy,u2); 
//scf(6); clf; surf(xx,yy,err2);
