package graphdrawing;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GraphDrawing extends JFrame {

    private JPanel canvas;
    private JCheckBox gridCheckBox, colorCheckBox;
    private boolean showGrid = false;
    private JComboBox<String> styleComboBox, functionComboBox, colorComboBox;
    private String drawingStyle = "pencil";
    private Color graphColor = Color.BLACK;
    private String functionType = "sin";
    private JTextField xValueField, yValueField;
    private int xAxisPosition = 400, yAxisPosition = 300;
    private java.util.List<String> functionsToDraw = new java.util.ArrayList<>();
    

    public GraphDrawing() {
        setTitle("Рисуем график функции");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        canvas = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                if (showGrid) {
                    drawGrid(g);
                }
                
                drawGraph(g);
                drawAxes(g);
                drawAxisLabels(g);
            }            
        };

        gridCheckBox = new JCheckBox("Сетка");
        gridCheckBox.addActionListener(e -> {
            showGrid = gridCheckBox.isSelected();
            canvas.repaint();
        });

        colorCheckBox = new JCheckBox("Выбор цвета");
        colorCheckBox.addActionListener(e -> {
            if(colorCheckBox.isSelected()) {
                Color newColor = JColorChooser.showDialog(this, "Выберите цвет", graphColor);
                if(newColor != null) {
                    graphColor = newColor;
                }
            }
            canvas.repaint();
        });

        styleComboBox = new JComboBox<>(new String[] {"Карандаш", "Щётка", "Перо"});
        styleComboBox.addActionListener(e -> {
            switch (styleComboBox.getSelectedItem().toString()) {
                case "Карандаш":
                    drawingStyle = "pencil";
                    break;
                case "Щётка":
                    drawingStyle = "brush";
                    break;
                case "Линия":
                    drawingStyle = "line";
                    break;
            }
            canvas.repaint();
        });

        functionComboBox = new JComboBox<>(new String[] {"sin", "cos", "tg","ctg"});
        functionComboBox.addActionListener(e -> {
            functionType = functionComboBox.getSelectedItem().toString();
        });

        xValueField = new JTextField(5);
        xValueField.addActionListener(e -> {
    try {
        xAxisPosition = Integer.parseInt(xValueField.getText());
        canvas.repaint();  // автоматическое обновление после ввода
    } catch (NumberFormatException ex) {
        JOptionPane.showMessageDialog(this, "Введите корректное значение для X.");
    }
});

        yValueField = new JTextField(5);
        yValueField.addActionListener(e -> {
    try {
        yAxisPosition = Integer.parseInt(yValueField.getText());
        canvas.repaint();  // автоматическое обновление после ввода
    } catch (NumberFormatException ex) {
        JOptionPane.showMessageDialog(this, "Введите корректное значение для Y.");
    }
});
        
        
        JButton drawButton = new JButton("Начертить");
        drawButton.addActionListener(e -> {
    functionsToDraw.clear();  // Очистить список перед добавлением новой функции
    functionsToDraw.add(functionComboBox.getSelectedItem().toString());
    canvas.repaint();
});

JButton clearButton = new JButton("Очистить");
clearButton.addActionListener(e -> {
    functionsToDraw.clear();
    canvas.repaint();
});

        JPanel controlPanel = new JPanel();
        controlPanel.add(gridCheckBox);
        controlPanel.add(colorCheckBox);
        controlPanel.add(styleComboBox);
        controlPanel.add(functionComboBox);
        /*controlPanel.add(new JLabel("X:"));
        controlPanel.add(xValueField);
        controlPanel.add(new JLabel("Y:"));
        controlPanel.add(yValueField);*/
        controlPanel.add(drawButton);
        controlPanel.add(clearButton);

        add(canvas, BorderLayout.CENTER);
        add(controlPanel, BorderLayout.SOUTH);
    }

    private void drawGraph(Graphics g) {
        Graphics2D g2d = (Graphics2D) g;
        g2d.setColor(graphColor);

        switch (drawingStyle) {
            case "pencil":
                g2d.setStroke(new BasicStroke(1));
                break;
            case "brush":
                g2d.setStroke(new BasicStroke(5));
                break;
            case "line":
                g2d.setStroke(new BasicStroke(3));
                break;
        }

        int prevX = -1;
        int prevY = -1;
        for (int x = 0; x < getWidth(); x++) {
            double value = 0;
            for (String function : functionsToDraw) {  // Используем функции из списка
            switch (function) {
                case "sin":
                    value = Math.sin((x - xAxisPosition) * 0.01);
                    break;
                case "cos":
                    value = Math.cos((x - xAxisPosition) * 0.01);
                    break;
                case "tg":
                    value = Math.tan((x - xAxisPosition) * 0.01);
                    break;
                    case "ctg":
                    value = 1/Math.tan((x - xAxisPosition) * 0.01);
                    break;
                    
                default:
                    value = x*x;
                    break;
            }

            int y = yAxisPosition - (int) (value * 100);
            if (prevX != -1 && prevY != -1 && Math.abs(prevY - y) < getHeight()) {
                g2d.drawLine(prevX, prevY, x, y);
            }
            prevX = x;
            prevY = y;
        }
    }
    }

    private void drawGrid(Graphics g) {
        g.setColor(Color.LIGHT_GRAY);
        for (int x = 0; x < getWidth(); x += 20) {
            g.drawLine(x, 0, x, getHeight());
        }
        for (int y = 0; y < getHeight(); y += 20) {
            g.drawLine(0, y, getWidth(), y);
        }
    }

    private void drawAxisLabels(Graphics g) {
        g.setColor(Color.BLACK);

        // Рисуем числовые метки для оси X
        for (int i = 0; i < getWidth(); i += 50) {
            if (i != xAxisPosition) { 
                int labelValue = (i - xAxisPosition)/50;// Чтобы не перекрыть ось Y
                g.drawString(String.valueOf(labelValue), i, yAxisPosition + 15);
            }
        }

        // Рисуем числовые метки для оси Y
        for (int i = 0; i < getHeight(); i += 50) {
            if (i != yAxisPosition) {
                int labelValue = (i - yAxisPosition)/50;// Чтобы не перекрыть ось X
                g.drawString(String.valueOf(labelValue), xAxisPosition - 30, i);
            }
        }
    }
    
    private void drawAxes(Graphics g) {
        g.setColor(Color.RED);
        g.drawLine(xAxisPosition, 0, xAxisPosition, getHeight());
        g.drawLine(0, yAxisPosition, getWidth(), yAxisPosition);
    }
    
    
    
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new GraphDrawing().setVisible(true));
    }
}
