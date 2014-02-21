function error = leastsquare(lamda,percentage)
load fisheriris
a = 150*percentage;
b = 150*(1-percentage);
 
%% get  training data and the remaining test data
p = randperm(150,a);
q = randperm(150);
t = setdiff(q,p);
train = rand(a,4);
test = rand(b,4);
for i=1:a
    train(i,:)=meas(p(i),:);
end
for i=1:b
    test(i,:)=meas(t(i),:);
end
one1 = ones(a,1);
one2 = ones(b,1);
x = [one1,train];
testx = [one2,test];
%% calculate T
t2 = zeros(a,3);
for i=1:a
    if(p(i)<=50)
        t2(i,1) = 1;
    end
    if(p(i)>50&&p(i)<=100)
        t2(i,2) = 1;
    end
    if(p(i)>100)
            t2(i,3) = 1;
    end
end
%% Caculate W and test 
W = inv(x'*x+lamda*eye(5))*x'*t2;
y = W'*testx';
y = y';
[~,testres] =max(y,[],2);
%% Calculate error
zz = 0;
for i = 1:b
    if(strcmp(species(t(i)),species(testres(i)*50)))
        zz= zz+1;
    end
end
correct =zz/b;
error = 1 - correct;
