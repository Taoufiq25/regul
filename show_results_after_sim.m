function show_results_after_sim()
% StopFcn callback: liest logsout aus base, berechnet und zeigt Tabelle

    % logsout muss im base workspace stehen (Signal logging aktivieren)
    %try
     %   out = evalin('base','out');
    %    logsout = out.logsout;

   % catch
     %   disp('Fehler: Variable ''logsout'' nicht im Base Workspace gefunden.');
     %   return
    %end

    % Namen anpassen falls deine Signale anders heißen:
    %ref = logsout.getElement('ref').Values;
    %sig = logsout.getElement('speed').Values;

    results = analyze_all_transitions('ref', 'speed');
    if isempty(results)
        disp('Keine Transitionen erkannt.');
        return
    end

    T = struct2table(results);
    assignin('base','TransitionResults',T); % optional

    % Zeige kleine GUI-Tabelle
    f = figure('Name','Transition Results','NumberTitle','off','MenuBar','none','ToolBar','none');
    uitable(f,'Data',table2cell(T),'ColumnName',T.Properties.VariableNames, ...
            'Position',[10 10 600 (40 + 25*height(T))]);
end
