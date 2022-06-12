load manual_labels
sum = 0;
for i=1:10
    image = read_as_grayscale(['church' num2str(i) '.jpg']); 
    [label, name] = classify_church(image, feature_collection);

    if strcmp(name, manual_labels(i))
        sum = sum+1;
    end
    disp([name, manual_labels(i)])
end
procent = sum*10;

disp([num2str(procent) '% of churches were matched correctly'])

