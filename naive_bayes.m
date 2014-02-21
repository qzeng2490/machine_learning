function error = naivebayes(percentage)
load fisheriris
%% get 10% training data and the remaining test data
p = randperm(150,150*percentage);
q = randperm(150);
t = setdiff(q,p);
train = rand(15,4);
test = rand(135,4);
for i=1:15 
    train(i,:)=meas(p(i),:);
end
for i=1:135 
    test(i,:)=meas(t(i),:);
end
train
test
%test = setdiff(meas,train,'rows')
%ismember(train,test,'rows')
%% calculate P(c)
pc = [0,0,0];
for i=1:15
    if(p(i)<=50)
        pc(1) = pc(1)+1;
    end
    if(p(i)>50&&p(i)<=100)
        pc(2) = pc(2)+1;
    end
    if(p(i)>100)
            pc(3) = pc(3)+1;
    end
end
pc0 = pc/15
%% store the edges  of histograms
f1 = 4:0.5:9.5;
f2 = 2:0.25:4.75;
f3 = 1:0.5:6.5;
f4 = 0:0.25:2.75;
edges = [f1;f2;f3;f4];
%[M,N] = size(edges);
%% Use histograms to estimate the probability distribution of each feature given each class
probability = zeros(3,4,11);

for i=1:3
    for j=1:4
        for k=1:11
            for h=1:15
                if(train(h,j)>=edges(j,k)&&train(h,j)<edges(j,k+1)&&strcmp(species(p(h)),species(i*50)))
                    probability(i,j,k) = probability(i,j,k)+1/pc(i);
                end
            end
        end
    end
end
%% Result Matrix
res1 = ones(135,1)*pc0(1);
res2 = ones(135,1)*pc0(2);
res3 = ones(135,1)*pc0(3);
res = [res1,res2,res3];
for i=1:135
    for j=1:3
        for k=1:4
            for h=1:11
                if(test(i,k)>=edges(k,h)&&test(i,k)<edges(k,h+1))
                    res(i,j) = res(i,j)*probability(j,k,h);
                end
            end
        end
    end
end
%%  Document all choices including percentages of each class  and the class probabilities used.
testres = zeros(135,1);
for i = 1:135
    temp = 0;
    col =1;
    for j = 1:3
        if(res(i,j)>temp)
            temp = res(i,j);
            col = j;
        end
    end
    if(temp == 0)
        testres(i) = randi(3);
    else
        testres(i) = col;
    end
end
%% Calculate error
x = 0;
for i = 1:135
    if(strcmp(species(t(i)),species(testres(i))))
        x= x+1;
    end
end
err =1 - x/135

