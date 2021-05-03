// definition de la fonction g
function value = g1(x,y)
    value = x*y
endfunction
function value = g2(x,y)
    value = exp(x+y)
endfunction
function value = g3(x,y)
    value = %e^x*cos(y)
endfunction

// parameters
M = 1000
h  = 0.1
// maillage
r = 0 : 0.1 : 1
theta = 0 : 0.1 : 2
// taille de maillage
Nr = size(r,2)
Nta = size(theta,2)
// store u
u = zeros(Nr, Nta)
err = zeros(Nr, Nta)
// u de X, Y precedents
//u2 = zeros(Nr, Nta)
//err2 = zeros(Nr, Nta)
// u du choix X,Y probabiliste
//u3 = zeros(Nr, Nta)
//err3 = zeros(Nr, Nta)
// store le nombre de pas
tm = zeros(Nr, Nta)

//boucles sur les points de depart
timer()
for i = 1 : Nr do
  for j = 1 : Nta do
    // initiate les resultats
    tab = zeros(M,1)
    //tab2 = zeros(M,1)
    //tab3 = zeros(M,1)
    time = zeros(M,1)
    // simulation des trajectoires
    for mc = 1 : M do
        // point de depart
      X = r(i)*cos(theta(j)*%pi)
      Y = r(i)*sin(theta(j)*%pi)
      // le point predesseur
      //X_pred = X
      //Y_pred = Y
      // while le point est dans D
      while X*X + Y*Y < 1 do
        //X_pred = X
        //Y_pred = Y
        // simuler Z
        Z = grand(2,1,'nor',0,1)
        X = X + sqrt(h)*Z(1)
        Y = Y + sqrt(h)*Z(2)
        time(mc) = time(mc) + 1
      end
      //choix probabiliste
      //d = 1 - sqrt(X_pred^2+Y_pred^2)
      //[P,p]=cdfchi("PQ",d^2/h,2)
      //U = grand(1,1,'def')
      //if U > p then
      //    tab3(mc) = g2(X,Y)
      //else
      //    tab3(mc) = g2(X_pred, Y_pred)
      //end
      tab(mc) = g2(X,Y)
      //tab2(mc) = g2(X_pred, Y_pred)
    end
  // calculer le moyen et le rayon de l'intervalle de confiance
  u(i,j) = mean(tab)
  err(i,j) = stdev(tab)
  //u2(i,j) = mean(tab2)
  //err2(i,j) = stdev(tab2)
  //u3(i,j) = mean(tab3)
  //err3(i,j) = stdev(tab3)
  tm(i,j) = mean(time)
  end
end
time = timer()
err = 1.96*err/sqrt(M)
//err2 = 1.96*err2/sqrt(M)
//err3 = 1.96*err3/sqrt(M)

// plot les resultats
[thth, rr] = meshgrid(theta, r)
xx = rr.*cos(thth*%pi)
yy = rr.*sin(thth*%pi)
scf(0); clf; surf(xx,yy, u);
scf(1); clf; surf(xx,yy, err);
scf(2); clf; surf(xx,yy,tm);
//scf(3); clf; surf(xx,yy,u2); 
//scf(4); clf; surf(xx,yy,err2);
//scf(5); clf; surf(xx,yy,u2); 
//scf(6); clf; surf(xx,yy,err2);
