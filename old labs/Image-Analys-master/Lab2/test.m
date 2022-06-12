[imgs_test, labels_test] = digitTest4DArrayData;

truelabel2 = net.classify(imgs_test) == labels_test;

nbrcorr1 = (sum(truelabel2)/length(imgs_test))*100;

disp([num2str(nbrcorr1) '% of the test numbers where classified correctly'])

wrong = find(truelabel2 == 0)


for i =1:5
u = wrong(i,1);    
wrongnr = net.classify(imgs_test(:,:,:,u));
k = char(wrongnr);
imwrite(imgs_test(:,:,:,u, (['mistaken_as_' k '.png'])))
end
