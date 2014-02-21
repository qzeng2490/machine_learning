error = zeros(11,3);
probability = [0.1,0.3,0.5];
lamda = 10.^[-5:5];
for i=1:11
    for j=1:3
        for k=1:10
            error(i,j) = error(i,j)+leastsquare(lamda(i),probability(j));
        end
    end
end
error = error/10;
x = [-5:5];
figure
plot(x,error(:,1),'-g',x,error(:,2),'--b',x,error(:,3),':c')
xlabel('lamda.' ); ylabel('error');
hleg1 =legend('10% training data','30% training data','50% training data');
set(hleg1,'Location','NorthWest');
set(hleg1,'Interpreter','none');
