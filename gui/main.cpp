#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QPushButton>
#include <QIcon>
#include "message.h"

class App
{
public:
    App(int& argc, char** argv)
        : app(argc, argv)
    { }

    int exec()
    {
        QMainWindow* window = new QMainWindow;
        QWidget*     widget = new QWidget;
        QVBoxLayout* layout = new QVBoxLayout;
        QPushButton* button = new QPushButton("go");
        Message*     msg    = new Message;

        QIcon icon(":/res/icon.png");
        app.setWindowIcon(icon);

        window->setCentralWidget(widget);
        widget->setLayout(layout);
        layout->addWidget(button);

        QObject::connect(button, &QPushButton::clicked, msg, &Message::onGo);

        window->show();
        return app.exec();
    }

    QApplication app;
};

int main(int argc, char** argv)
{
    return App(argc, argv).exec();
}


