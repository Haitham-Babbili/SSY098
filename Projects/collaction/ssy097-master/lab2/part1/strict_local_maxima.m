function maxima = strict_local_maxima(image, threshold, gaussian_std)
        
        % Probmap är 3D. Det verkar som probmap(:,:,1) är sannolikheten för
        % att det INTE finns en cell och probmap(:,:,2) är sannolikheten
        % för att det finns en cell. Kan inte tolka det på nåt annat sätt. 
        
        probmap = image(:,:,2);  
        filteredProb = gaussian_filter(probmap,gaussian_std); 
        
        % Kommentar från lab2 var att vi skulle använda 8 istället för 9 i
        % andra argumentet för ordfilt2. Inte säker på varför men det
        % funkar iaf. 
        max = ordfilt2(filteredProb, 8, ones(3));
        
        % Detta bör tillämpa threshold på rätt sätt. Testa med olike
        % thresholds så ser du skillnaden. 
        max(max<threshold) = threshold;
        [row, col] = find(filteredProb > max);
        
        
        maxima = [col row]';
        
        



end